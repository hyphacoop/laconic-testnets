# Hypha Laconic Devnet

This chain will be restarted regularly.

## Chain Details

* Genesis: [genesis.json](genesis.json)
* Binary repo: https://git.vdb.to/cerc-io/laconic2d
* Binary version: [9dc84ef943](https://git.vdb.to/cerc-io/laconic2d/commit/9dc84ef9438e32a40df4274de79f72abe6d6d9a7)
* Persistent peers
  ```
  96ee440163f4d7c194be63e00d90ade9152b4469@devnet.l.stg.earthball.xyz:26656
  ```
* RPC endpoints
  * http://devnet.l.stg.earthball.xyz:26657

## How to Join

The following steps will configure and start containers to run:
* laconicd
* laconic-console
* laconic-registry-cli

1. Set up Docker and Laconic's Stack Orchestrator in your machine using [this script](https://raw.githubusercontent.com/cerc-io/stack-orchestrator/main/scripts/quick-install-linux.sh).
2. Use Stack Orchestrator to configure and start `laconicd` and `laconic-console` containers using [this script](https://github.com/hyphacoop/laconic-testnets/raw/main/devnet/setup-containers.sh).
3. To confirm the node is online, check the log using this command:
   ```
   laconic-so deployment --dir testnet-laconicd-deployment logs laconicd -f
   ```
