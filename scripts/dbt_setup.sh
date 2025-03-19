#!/bin/bash

# Usage: dbt_setup dev | dbt_setup prod

if [ -z "$1" ]; then
    echo "Usage: dbt_setup dev | dbt_setup prod"
    return 1
fi

# Define paths
DBT_BASE=$(dirname "$(realpath "$0")")/..
DBT_ENV_VARS="$DBT_BASE/env_vars/$1.env"
DBT_VENV="$DBT_BASE/envs/$1"
DBT_PROJECT="$DBT_BASE/dbt_project"  # Change this if needed

# Check if the environment variable file exists
if [ ! -f "$DBT_ENV_VARS" ]; then
    echo "Error: Environment file '$DBT_ENV_VARS' not found!"
    return 1
fi

# Check if the virtual environment exists
if [ ! -d "$DBT_VENV" ]; then
    echo "Error: Virtual environment '$DBT_VENV' not found!"
    return 1
fi

# Load environment variables
export $(grep -v '^#' "$DBT_ENV_VARS" | xargs)
echo "Loaded environment for $1 dbt project."

# Activate the virtual environment
source "$DBT_VENV/bin/activate"
echo "Activated virtual environment: $DBT_VENV"

# Change directory to the dbt project
cd "$DBT_PROJECT"
echo "Changed directory to: $DBT_PROJECT"

echo "Your dbt environment is ready!"
