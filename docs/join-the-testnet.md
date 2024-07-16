# How to Join the Laconic Testnet 

## Chain Details

* Pre-launch genesis: TBA
* Chain ID: TBA
* Denom: TBA
* Binary repo: https://git.vdb.to/cerc-io/laconic2d
* Binary version: TBA
* Persistent peers: TBA
* RPC endpoints: TBA
* Block explorer: TBA

## Joining the Laconic Chain

The following steps will configure and start containers to run:
* laconicd
* laconic-console
* laconic-registry-cli

## Set up Docker and Stack Orchestratror

Run [this script](https://raw.githubusercontent.com/cerc-io/stack-orchestrator/main/scripts/quick-install-linux.sh) on the node machine to set up Docker and [Stack Orchestrator](https://git.vdb.to/cerc-io/stack-orchestrator).

## Configure and start the Laconic containers

Get `laconic-so` in the path (you can also log off and on after running the above script).
```
source ~/.profile
```

Clone the testnet stack repo and required repositories.
```
laconic-so fetch-stack git.vdb.to/cerc-io/testnet-laconicd-stack
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/testnet-laconicd setup-repositories
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/laconic-console setup-repositories
```
Build the container images.
```
# laconicd
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/testnet-laconicd build-containers
# laconic cli and console
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/laconic-console build-containers
```

Create the deployment spec files.
```
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/testnet-laconicd deploy init --output testnet-laconicd-spec.yml
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/laconic-console deploy init --output laconic-console-spec.yml
```
> Modify the spec files as required to expose container ports before creating the deployments directories.

Create deployment folders from the spec files and place both deployments in the same namespace.
```
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/testnet-laconicd deploy create --spec-file testnet-laconicd-spec.yml --deployment-dir testnet-laconicd-deployment
laconic-so --stack ~/cerc/testnet-laconicd-stack/stack-orchestrator/stacks/laconic-console deploy create --spec-file laconic-console-spec.yml --deployment-dir laconic-console-deployment
cp testnet-laconicd-deployment/deployment.yml laconic-console-deployment/deployment.yml
```

Copy over the genesis file.
```
mkdir -p testnet-laconicd-deployment/data/laconicd-data/tmp
wget [genesis URL] -O testnet-laconicd-deployment/data/laconicd-data/tmp/genesis.json
```

Update the laconicd deployment's config.env with the public peers.
```
echo "CERC_PEERS=\"[peers]\"" >> testnet-laconicd-deployment/config.env
```

Start the deployments.
```
laconic-so deployment --dir testnet-laconicd-deployment start
laconic-so deployment --dir laconic-console-deployment start
```

## Confirm the node is running

Check the `laconicd` log using this command:
```
laconic-so deployment --dir testnet-laconicd-deployment logs laconicd -f
```
Blocks will not be produced until enough validators start running their nodes to reach consensus.
