#!/bin/bash

# Add git clone frappe_docker
#git clone https://github.com/frappe/frappe_docker.git
## shellcheck disable=SC2164
#cd frappe_docker


# Define the custom apps you want to include
# shellcheck disable=SC2089
APPS_JSON='[
  {
    "url": "https://github.com/frappe/erpnext",
    "branch": "version-15"
  },
  {
    "url": "https://github.com/frappe/frappe",
    "branch": "version-15"
  },
  {
    "url": "https://github.com/frappe/hrms",
    "branch": "version-15"
  }
]'

# Encode the apps.json content to base64
# shellcheck disable=SC2090
APPS_JSON_BASE64=$(echo -n $APPS_JSON | base64)

# Build the docker image
docker build \
  --no-cache \
  --build-arg=FRAPPE_PATH=https://github.com/frappe/frappe \
  --build-arg=FRAPPE_BRANCH=version-15 \
  --build-arg=PYTHON_VERSION=3.10.12 \
  --build-arg=NODE_VERSION=18 \
  --build-arg=APPS_JSON_BASE64=$APPS_JSON_BASE64 \
  --tag=ghcr.io/user/repo/custom:1.0.0 \
  --file=images/production/Containerfile .
