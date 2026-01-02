# Memos Alfred Workflow

Quick memo creation for self-hosted [Memos](https://usememos.com) via Alfred.

## Usage

```
m your memo text here
```

## Installation

1. Copy this workflow folder to `~/Library/Application Support/Alfred/Alfred.alfredpreferences/workflows/`
2. Open Alfred Preferences → Workflows → Memos
3. Set `MEMOS_TOKEN` in the workflow configuration (get from Memos Settings → Access Tokens)
4. Set `MEMOS_URL` to your Memos instance URL

## Configuration

| Variable | Required | Default | Description |
|----------|----------|---------|-------------|
| `MEMOS_TOKEN` | Yes | - | Access token from Memos |
| `MEMOS_URL` | Yes | - | Your Memos instance URL (e.g., `http://localhost:5230`) |

## How It Works

Uses the Memos REST API (`/api/v1/memos`) to create private memos.

## Requirements

- Alfred with Powerpack
- `curl` (included in macOS)
