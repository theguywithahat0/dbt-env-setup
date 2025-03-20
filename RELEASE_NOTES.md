# Release Notes - v1.0.0

## dbt Environment Setup v1.0.0

This is the initial stable release of the DBT Environment Setup toolkit, providing a streamlined solution for managing multiple DBT project environments.

### Features

- **Environment-Specific Variables**: Separate configuration files for different contexts (dev, prod, custom)
- **Isolated Python Environments**: Virtual environment management for dependency isolation
- **Flexible Project Paths**: Each environment can point to different repositories or branches
- **Default Fallback Environment**: Quick access via `env_dbt` command
- **Custom Shell Aliases**: Simplified commands for common operations
- **BigQuery Support**: Pre-configured installation for dbt-bigquery adapter
- **Optional Custom Profiles**: Centralized profiles.yml management

### Getting Started

1. Clone the repository
2. Create your environments
3. Set up your environment files
4. Activate an environment with `source scripts/dbt_setup.sh <env_name>`

Refer to the README.md for detailed setup instructions and examples.

### Compatibility

- Tested with Python 3.8+
- Supports dbt-core and dbt-bigquery adapter
- Works on Linux, macOS, and WSL environments
