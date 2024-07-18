# How to Register an Authority

This guide demonstrates how to register an authority using `laconic-registry-cli`.

### Prerequisites

* Start the `laconicd` and `laconic-registry-cli` containers using the script in the [How to Join](/devnet/README.md#how-to-join) section of the README.
* Obtain a private key in the format shown in [this guide](private-key.md).
* Configure a user key for `laconic-registry-cli` as shown in [this guide](configure-cli-key.md).
* Create a bond using [this guide](./create-bond.md)
* Configure the bond for `laconic-registry-cli` as shown in [this guide](./configure-cli-bond.md)

## Register an Authority

* Reserve the name with the account previously configured in `laconic-registry-cli`.
```
laconic-so deployment --dir laconic-console-deployment exec cli "laconic registry authority reserve loro"
{"success": true}
```
* Set the name with the previously created bond id.
```
laconic-so deployment --dir laconic-console-deployment exec cli "laconic registry authority bond set loro fbea5d17b6a8b71c8e8fb971977b6cd2e1900621d8cbb0e463646f21d69b38ef"
{"success": true}
```
* Verify the authority has been registered.
```
laconic-so deployment --dir laconic-console-deployment exec cli "laconic registry authority whois loro"
```