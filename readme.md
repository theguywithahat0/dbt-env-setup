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

# Install dependencies (while in the repository directory)
bash install_dbt.sh
```

## ✨ Features

### 1. Environment-Specific Variables
Sample environment variable files are provided in `env_vars/`:
- `dev.env` - Development configuration sample
- `prod.env` - Production configuration sample
- Create additional environment files as needed (e.g., `staging.env`, `my_project.env`)

These files allow you to maintain separate configurations for different contexts.

### 2. Isolated Virtual Environments
The `envs/` directory structure lets you create separate Python environments:
- Each environment keeps its dependencies isolated
- Prevents conflicts between development and production packages
- Allows different Python versions for different environments
- Create project-specific environments (e.g., `envs/my_project`)

### 3. Environment Setup Script
The `scripts/dbt_setup.sh` script provides a single command to:
- Load environment-specific variables
- Activate the corresponding virtual environment
- Navigate to the appropriate project directory (if configured)

### 4. Environment-Specific Project Paths
Using the `DBT_PROJECT_PATH` variable in each environment file, you can:
- Point different environments to different repositories or branches
- Use completely separate project directories for different contexts
- Organize your work by project and environment

### 5. Default Fallback Environment
A default environment (`env_default` alias) is provided as a fallback:
- Quick access to a general-purpose environment
- Useful for tests or one-off operations
- No project-specific configuration needed

### 6. Shell Aliases (Optional)
The `.bash_aliases.sample` file provides convenient shortcuts:
- `project_setup <env>` - Quick environment activation
- `env_default` - Activate the default fallback environment
- `load_env <env>` - Load variables without switching environments
- `create_env <env> [python_version]` - Create new environments

> ⚠️ **Note:** Using the shell aliases requires updating the `ENV_SETUP_DIR` variable in the `.bash_aliases.sample` file to match your actual installation path. This is an optional but recommended step for frequent users.

## 📂 Repository Structure

```
dbt-env-setup/
├── env_vars/             # Environment variable files
│   ├── dev.env           # Development variables
│   └── prod.env          # Production variables
├── envs/                 # Virtual environments (gitignored)
│   └── .gitkeep          # Placeholder to maintain folder structure
├── scripts/
│   └── dbt_setup.sh      # Main environment setup script
├── install_dbt.sh        # Script to install dbt-core
├── .bash_aliases.sample  # Shell configuration examples
├── LICENSE               # MIT License
├── .gitignore            # Git ignore rules
└── README.md             # This documentation
```

## 🔧 Setting Up Your Custom Workspace: Example Walkthrough

This walkthrough will guide you through setting up a complete environment for a project called `my_dbt_project`.

1. **Clone the environment setup repository**
   ```bash
   git clone https://github.com/theguywithahat0/dbt-env-setup.git
   cd dbt-env-setup
   ```

2. **Create a project-specific environment**
   ```bash
   # Create a dedicated environment for your project
   python3 -m venv envs/my_dbt_project
   ```

3. **Create a project-specific environment file**
   ```bash
   # Create and edit the my_dbt_project.env file
   nano env_vars/my_dbt_project.env
   ```
   
   Add these contents:
   ```
   DBT_ENV=my_dbt_project
   DBT_PROJECT_PATH=/home/username/projects/my_dbt_project
   WAREHOUSE=my_warehouse
   ```

4. **Set up shell aliases (optional)**
   ```bash
   # Copy the sample file to your home directory
   cp .bash_aliases.sample ~/.bash_aliases
   
   # Edit the file to update the ENV_SETUP_DIR path
   nano ~/.bash_aliases
   ```
   
   Update this line in the file:
   ```bash
   ENV_SETUP_DIR="/home/username/dbt-env-setup"  # Update with your actual path
   ```
   
   Then source the file:
   ```bash
   source ~/.bash_aliases
   ```

5. **Configure your dbt profiles**
   ```bash
   # Create the .dbt directory in the env-setup repository
   mkdir -p $ENV_SETUP_DIR/.dbt
   
   # Create or edit the profiles.yml file
   nano $ENV_SETUP_DIR/.dbt/profiles.yml
   ```
   
   Add your connection details to the profiles.yml file:
   ```yaml
   my_dbt_project:
     target: dev
     outputs:
       dev:
         type: snowflake
         account: youraccount
         user: your_dev_user
         password: your_password
         role: DEV_ROLE
         database: DEV_DB
         warehouse: DEV_WH
         schema: DEV_SCHEMA
         threads: 4
       prod:
         type: snowflake
         account: youraccount
         user: your_prod_user
         password: your_password
         role: PROD_ROLE
         database: PROD_DB
         warehouse: PROD_WH
         schema: PROD_SCHEMA
         threads: 4
   ```
   
   > **Note:** The setup will use this centralized profiles location instead of the default ~/.dbt/profiles.yml

6. **Clone your actual DBT project**
   ```bash
   # Create the project directory
   mkdir -p /home/username/projects/my_dbt_project
   
   # Clone your repo (example - substitute with your actual project)
   git clone https://github.com/your-username/my_dbt_project.git /home/username/projects/my_dbt_project
   ```

6. **Activate your project environment**
   ```bash
   # If you set up the aliases:
   project_setup my_dbt_project
   
   # Or without aliases (must be run from any directory):
   source /path/to/dbt-env-setup/scripts/dbt_setup.sh my_dbt_project
   ```

7. **Install DBT and dependencies**
   ```bash
   # If in the repository directory:
   bash install_dbt.sh
   
   # Or if you set up aliases (can be run from any directory):
   bash $ENV_SETUP_DIR/install_dbt.sh
   
   # Or without aliases (must specify full path):
   bash /path/to/dbt-env-setup/install_dbt.sh
   ```

8. **Verify your setup**
   ```bash
   # Check that DBT is installed
   dbt --version
   
   # You should already be in your project directory
   # due to the DBT_PROJECT_PATH setting
   dbt debug
   ```

9. **Use the default environment when needed**
   ```bash
   # If you set up aliases:
   env_default
   
   # Without aliases:
   source /path/to/dbt-env-setup/envs/env/bin/activate
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

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔒 Security Note

Remember that environment files may contain sensitive information. They are included in this repository for demonstration purposes, but in practice:

- Never commit real credentials or sensitive data to the repository
- Consider using a secrets manager for production environments
- Add appropriate entries to `.gitignore` to prevent accidental commits
