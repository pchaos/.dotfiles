# AGENTS.md

This file contains guidelines for agentic coding agents working in this dotfiles repository.

## Build, Lint, and Test Commands

### Python Testing
```bash
# Run all tests in a test file (standard)
cd /home/user/.dotfiles/bash/.gemini/antigravity/scratch
timeout 15s pytest -v -rs -s test_coloredBuildLog.py

# Run a single test
timeout 15s pytest -v -rs -s test_coloredBuildLog.py::TestProgressColoring::test_progress_0_percent

# Run a specific test class
timeout 15s pytest -v -rs -s test_coloredBuildLog.py::TestProgressColoring

# Run tests with coverage (if available)
timeout 15s pytest -v -rs -s --cov=module_name test_file.py
```

### Shell Script Execution
```bash
# Make scripts executable if needed
chmod +x script.sh

# Execute shell scripts
./script.sh
# or
bash script.sh
```

### Docker Build Environment (OpenWrt)
```bash
cd /home/user/.dotfiles/bash/.gemini/antigravity/scratch/openwrt_build

# Build the base environment
docker-compose build base-env

# Run compilation with current directory
docker-compose run --rm compiler

# Run with custom source directory
OPENWRT_SRC=/path/to/source docker-compose run --rm compiler

# Run with custom build script
OPENWRT_BUILD_SCRIPT=./debug.sh docker-compose run --rm compiler

# Enter container for debugging
docker-compose up -d base-env
docker-compose exec base-env bash
```

### General Repository Commands
```bash
# Install dotfiles (from repo root)
./install-demo    # Demo installation
./install-personal # Personal config
./install-work     # Work config
```

## Code Style Guidelines

### Python Code
- **Testing**: Use `unittest.TestCase` as the base class
- **Test Naming**: Name test classes as `TestXxx` where `Xxx` is the capitalized feature name
- **Test Structure**: Start simple and gradually increase complexity
- **Assertions**: Always provide detailed assertion messages including actual and expected values
  ```python
  self.assertEqual(actual, expected, 
                   f"Failed: got {actual}, expected {expected}")
  ```
- **Mocking**: Use mock objects where appropriate to isolate functionality
- **Test Execution**: Always use `timeout 15s` prefix for pytest commands
- **Test Parameters**: Use `-v -rs -s` flags for verbose, skipped reason, and output

### Shell Scripts (Bash)
- **Shebang**: Always use `#!/bin/bash` at the top
- **Error Handling**: Include these standard settings:
  ```bash
  set -e
  set -o pipefail
  ```
- **Function Definition**: Use descriptive function names with clear separation
- **Comments**: Use multi-language support (Chinese and English) for documentation
- **File Permissions**: Ensure scripts are executable with `chmod +x`
- **Output Formatting**: Use ANSI color codes for terminal output consistency
  ```bash
  RED='\033[31m'
  GREEN='\033[32m'
  YELLOW='\033[33m'
  RESET='\033[0m'
  echo -e "${GREEN}Success${RESET}"
  ```

### AWK Scripts
- **Function Usage**: Define reusable functions for common operations
- **Color Function**: Use consistent color formatting function:
  ```awk
  function clr(c,s) { return "\033[" c "m" s "\033[0m" }
  ```
- **Pattern Matching**: Use regex patterns for log parsing and highlighting

### File Naming Conventions
- **Python files**: `snake_case.py` (e.g., `test_coloredBuildLog.py`)
- **Shell scripts**: `kebab-case.sh` or `camelCase.sh` (e.g., `showlog.sh`, `coloredBuildLog.sh`)
- **AWK files**: `snake_case.awk`
- **README files**: `README.md` or `readme.md`
- **Configuration**: Use leading dot for hidden configs (`.env`, `.gitignore`)

### Imports and Dependencies
- **Python**: Import standard library first, then third-party packages
- **Shell**: No explicit imports, but ensure external commands exist before use
- **Dependencies**: The repo uses `npm` for some tools (markmap, playwright)

### Error Handling
- **Python**: Use try/except blocks with specific exception types
- **Shell**: Check command exit codes and file existence before operations:
  ```bash
  if [ ! -f "$FILE" ]; then
      echo "Error: File not found: $FILE" >&2
      exit 1
  fi
  ```
- **Logging**: Use `>&2` for error messages to stderr

### Code Organization
- **Directory Structure**:
  - `bash/`: Shell scripts and bash configurations
  - `bash/.gemini/antigravity/scratch/`: Development and test files
  - `bash/.gemini/antigravity/scratch/openwrt_build/`: OpenWrt Docker build environment
  - `submodule/`: Git submodules for external tools
- **Temporary Files**: Use system temporary directory (`/tmp` or `tempfile.NamedTemporaryFile`)

### Git Commit Conventions
- Use conventional commit format when appropriate: `feat:`, `fix:`, `docs:`, `chore:`, etc.
- Keep messages concise but descriptive
- Do NOT commit changes without explicit user permission
- Support multi-language commit messages (Chinese/English)

### Docker Guidelines
- **Base Images**: Use official images when possible (e.g., `ubuntu:24.04`)
- **Layers**: Combine related commands to minimize layers
- **Security**: Create non-root users for build processes
- **Environment**: Set `DEBIAN_FRONTEND=noninteractive` to avoid prompts
- **Cleanup**: Always clean package cache in the same layer

### Important Notes
- This repository is managed by GNU Stow for dotfile installation
- Some submodules use `git-crypt` for encrypted content
- Never modify code without explicit user request
- Always provide clear reasoning for changes not explicitly requested
- Maintain existing code style and patterns
- Keep scripts portable across different systems
- Always use absolute paths when referencing repository files
