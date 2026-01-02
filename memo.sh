#!/bin/bash
# Memos Alfred Workflow - Create memo via REST API

if [[ -z "$MEMOS_URL" ]]; then
    echo "Error: MEMOS_URL not set"
    exit 1
fi

if [[ -z "$MEMOS_TOKEN" ]]; then
    echo "Error: MEMOS_TOKEN not set"
    exit 1
fi

content="$1"

if [[ -z "$content" ]]; then
    echo "Usage: m <your memo>"
    exit 1
fi

# Escape content for JSON
json_content=$(printf '%s' "$content" | python3 -c 'import sys,json; print(json.dumps(sys.stdin.read()))')

response=$(curl -s -w "\n%{http_code}" \
    -X POST "${MEMOS_URL}/api/v1/memos" \
    -H "Authorization: Bearer $MEMOS_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"content\": $json_content, \"visibility\": \"PRIVATE\"}")

http_code=$(echo "$response" | tail -1)

if [[ "$http_code" == "200" ]]; then
    echo "Memo created!"
else
    echo "Failed (HTTP $http_code)"
    exit 1
fi
