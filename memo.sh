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

# Escape quotes and backslashes for JSON
escaped=$(printf '%s' "$content" | sed 's/\\/\\\\/g; s/"/\\"/g')

response=$(curl -s -w "\n%{http_code}" \
    -X POST "${MEMOS_URL}/api/v1/memos" \
    -H "Authorization: Bearer $MEMOS_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{\"content\": \"$escaped\", \"visibility\": \"PRIVATE\"}")

http_code=$(echo "$response" | tail -1)

if [[ "$http_code" == "200" ]]; then
    echo "Memo created!"
else
    echo "Failed (HTTP $http_code)"
    exit 1
fi
