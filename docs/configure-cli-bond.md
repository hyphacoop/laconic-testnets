# How to Configure a User Bond id for laconic-registry-cli

This guide demonstrates how to configure `laconic-registry-cli`.

### Prerequisites

* Start the `laconicd` and `laconic-registry-cli` containers using the script in the [How to Join](/devnet/README.md#how-to-join) section of the README.
* Create a bond as shown in [this guide](create-bond.md).

## Configuration 

## 1. Stop the laconic-registry-cli container
```
laconic-so deployment --dir laconic-console-deployment stop
```
## Add the key to config.env
* Set the following key in `laconic-console-deployment/config.env`
```
CERC_LACONICD_BOND_ID=<bond id>
```

## Start the laconic-registry-cli container
```
laconic-so deployment --dir laconic-console-deployment start
```