#!/bin/bash

# CONFIGURABLE VARIABLES
CONTAINER_NAME="kc"
REALM_NAME="NAME"
EXPORT_DIR="/opt/keycloak/data/export"
FILE_NAME="${REALM_NAME}-realm.json"

# Create export directory on host (optional, if mounting)
mkdir -p ./keycloak-export

# Run export command inside the Docker container
docker exec -it $CONTAINER_NAME /opt/keycloak/bin/kc.sh export \
  --dir=$EXPORT_DIR \
  --realm=$REALM_NAME \
  --users=realm_file

# Copy exported realm file from container to host
docker cp "$CONTAINER_NAME:$EXPORT_DIR/$REALM_NAME-realm.json" "./keycloak-export/$FILE_NAME"

echo "Exported realm '$REALM_NAME' to ./keycloak-export/$FILE_NAME"
