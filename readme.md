# DBT Environment Setup

A streamlined toolkit for managing DBT project environments with isolated dependencies and environment-specific configurations.

## 📋 Overview

This repository provides a lightweight solution for data engineers working with DBT projects across different environments (development, production, etc.) with:

- Environment-specific variable files
- Isolated Python virtual environments 
- Helper scripts for quick environment switching
- Simple installation of dbt-core and dependencies

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/theguywithahat0/dbt-env-setup.git
cd dbt-env-setup

# Create your virtual environments
python3 -m venv envs/dev
python3 -m venv envs/prod

# Set up development environment
source scripts/dbt_setup.sh dev

# Install dependencies (with virtual environment active)
bash install_dbt.sh
```

## 📂 Repository Structure

```
env-setup/
├── env_vars/             # Environment variable files
│   ├── dev.env           # Development variables
│   └── prod.env          # Production variables
├── envs/                 # Virtual environments (gitignored)
│   └── .gitkeep          # Placeholder to maintain folder structure
├── scripts/
│   └── dbt_setup.sh      # Main environment setup script
├── install_dbt.sh        # Script to install dbt-core
├── .bash_aliases.sample  # Shell configuration examples
├── .gitignore            # Git ignore rules
└── README.md             # This documentation
```

## 💻 Environment Setup

### Creating Virtual Environments

Create customized Python environments for each context:

```bash
# Create a default environment
python3 -m venv envs/env

# Create development/production environments
python3 -m venv envs/dev
python3 -m venv envs/prod
```

### Loading an Environment

Use the provided setup script to load variables and activate your environment:

```bash
# Development setup
source scripts/dbt_setup.sh dev

# Production setup
source scripts/dbt_setup.sh prod
```

The script will:
- Load environment variables from `env_vars/<environment>.env`
- Activate the corresponding virtual environment
- Navigate to your DBT project directory (configurable in the script)

### Installing Dependencies

After activating your environment:

```bash
bash install_dbt.sh
```

This will install `dbt-core` in your active virtual environment.

## ⚙️ Environment Variables

Example environment variable files are included:

**dev.env**
```
DBT_ENV=dev
SAMPLE_VAR_1=1
```

**prod.env**
```
DBT_ENV=prod
SAMPLE_VAR_1=2
```

You can create additional environment files as needed (e.g., `staging.env`, `testing.env`).

## 🔧 Shell Configuration

For easier workflow, you can use the provided shell aliases:

1. Copy the sample file:
   ```bash
   cp .bash_aliases.sample ~/.bash_aliases
   ```

2. Source it:
   ```bash
   source ~/.bash_aliases
   ```

3. Use the included helpers:
   ```bash
   # Load development environment (runs dbt_setup.sh)
   project_setup dev
   
   # Activate default environment
   env_default
   
   # Manually load environment variables
   load_env dev
   
   # Create a new environment
   create_env staging 3.9  # Optional Python version specification
   ```

## 🛠️ Customization

### Modifying the DBT Setup Script

The main `dbt_setup.sh` script can be customized to suit your project:

1. Open `scripts/dbt_setup.sh` in your editor
2. Update the `DBT_PROJECT` path to match your DBT project location
3. Add any additional setup steps needed for your workflow

### Adding New Dependencies

To add more dependencies beyond dbt-core:

1. Edit `install_dbt.sh` to include additional packages:
   ```bash
   #!/bin/bash
   echo "Installing dbt-core and dependencies..."
   pip install dbt-core
   pip install dbt-postgres  # For PostgreSQL adapter
   pip install pandas        # For data manipulation
   echo "Installation complete."
   ```

## 🔍 Troubleshooting

### Common Issues

**Virtual Environment Not Found**
```
Error: Virtual environment '/path/to/envs/dev' not found!
```
Solution: Create the environment with `python3 -m venv envs/dev`

**Environment Variables Not Loading**
Check that your environment file:
- Exists in the correct location (`env_vars/<environment>.env`)
- Has no spaces around the equal signs (`KEY=value`, not `KEY = value`)
- Contains no syntax errors

**Script Must Be Sourced**
```
Error: This script must be sourced, not executed.
```
Solution: Use `source scripts/dbt_setup.sh dev` instead of `./scripts/dbt_setup.sh dev`

## 📝 Contributing

Feel free to customize this repository for your specific needs. If you make improvements, consider contributing them back via pull request!

## 🔒 Security Note

Remember that environment files may contain sensitive information. They are included in this repository for demonstration purposes, but in practice:

- Never commit real credentials or sensitive data to the repository
- Consider using a secrets manager for production environments
- Add appropriate entries to `.gitignore` to prevent accidental commits
