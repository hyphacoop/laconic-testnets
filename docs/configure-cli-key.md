# How to Configure a User Key for laconic-registry-cli

This guide demonstrates how to configure `laconic-registry-cli`.

### Prerequisites

* Deploy the `laconicd` and `laconic-registry-cli` containers using the script in the [How to Join](/devnet/README.md#how-to-join) section of the README.
* Obtain a private key in the format shown in [this guide](private-key.md).

## Configuration 

## 1. Stop the laconic-registry-cli container
```
laconic-so deployment --dir laconic-console-deployment stop
```
## Add the key to config.env
* Set the following key in `laconic-console-deployment/config.env`
```
CERC_LACONICD_USER_KEY=<private key in unarmored hex format>
```

## Start the laconic-registry-cli container
```
laconic-so deployment --dir laconic-console-deployment start
```