# Personal Commands

This directory contains personal command scripts that are added to your PATH.

## Setup

Run `make bin` to create symbolic links to individual files in `~/bin/`.

**Note**: This only links individual files, not the entire directory, so existing `~/bin/` contents are preserved.

## Usage

- Place executable scripts in this directory
- Scripts will be available as commands after running `make bin`
- Use `chmod +x script_name` to make scripts executable

## Examples

Create a new command:
```bash
cat > bin/hello << 'EOF'
#!/bin/bash
echo "Hello, World!"
EOF
chmod +x bin/hello
make bin
```

Then use it anywhere:
```bash
hello
```

## Available Commands

### okite
PagerDuty incident creation tool (寝坊した人を起こします)

**Setup:**
```bash
export PAGERDUTY_API_TOKEN=your_token_here
# Add to ~/.zshrc to persist
```

**Usage:**
```bash
# Interactive mode (recommended for first-time users)
okite --interactive

# List available services and users
okite --list-services
okite --list-users

# Create incident directly
okite -s SERVICE_ID -t "Incident Title" -d "Description" -u USER_ID

# With custom urgency
okite -s SERVICE_ID -t "Title" -d "Description" -u USER_ID -U low
```

**Options:**
- `-s, --service-id`: PagerDuty service ID
- `-t, --title`: Incident title
- `-d, --description`: Incident description  
- `-u, --user-id`: User ID to assign incident to
- `-U, --urgency`: Incident urgency (high/low, default: high)
- `-i, --interactive`: Interactive mode with prompts
- `--list-services`: List available services
- `--list-users`: List available users
- `-h, --help`: Show help

## Safety

The `make bin` command:
1. Creates `~/bin/` directory if it doesn't exist
2. Links only individual executable files from this directory
3. Preserves any existing files in `~/bin/`
4. Skips README.md and non-executable files