#!/bin/bash

GENESIS_URL=https://github.com/hyphacoop/laconic-testnets/raw/main/devnet/genesis.json
PEERS=96ee440163f4d7c194be63e00d90ade9152b4469@devnet.l.stg.earthball.xyz:26656

# Get laconic-so in the path
source ~/.profile

# Clone the stack repo
laconic-so fetch-stack git.vdb.to/cerc-io/testnet-laconicd-stack

# Clone the required repositories
# laconicd
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/testnet-laconicd setup-repositories
# laconic cli and console
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/laconic-console setup-repositories

# Build the container images
# laconicd
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/testnet-laconicd build-containers
# laconic cli and console
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/laconic-console build-containers

# Create deployment spec files
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/testnet-laconicd deploy init --output testnet-laconicd-spec.yml
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/laconic-console deploy init --output laconic-console-spec.yml

# Modify the spec files as required to expose container ports before creating the deployments directories.

# Create deployments from spec files
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/testnet-laconicd deploy create --spec-file testnet-laconicd-spec.yml --deployment-dir testnet-laconicd-deployment
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/laconic-console deploy create --spec-file laconic-console-spec.yml --deployment-dir laconic-console-deployment
# Place them both in the same namespace (cluster)
cp testnet-laconicd-deployment/deployment.yml laconic-console-deployment/deployment.yml

# Copy over the genesis file
mkdir -p testnet-laconicd-deployment/data/laconicd-data/tmp
wget $GENESIS_URL -O testnet-laconicd-deployment/data/laconicd-data/tmp/genesis.json

# Update config.env with the public peer
echo "CERC_PEERS=\"$PEERS\"" >> testnet-laconicd-deployment/config.env

# Start the deployments
laconic-so deployment --dir testnet-laconicd-deployment start
laconic-so deployment --dir laconic-console-deployment start