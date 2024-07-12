# How to Create a Bond

This guide demonstrates how to create a bond using `laconic-registry-cli`.

### Prerequisites

* Deploy the `laconicd` and `laconic-registry-cli` containers using the script in the [How to Join](/devnet/README.md#how-to-join) section of the README.
* Obtain a private key in the format shown in [this guide](private-key.md).
* Configure a user key for `laconic-registry-cli` as shown in [this guide](configure-cli-key.md).

## Bond Creation

The following transaction will create a `100000000000photon` bond with the account `laconic-registry-cli` has been configured with.
```
laconic-so deployment --dir laconic-console-deployment exec cli "laconic registry bond create --type photon --quantity 100000000000"
{"bondId":"a742489e5817ef274187611dadb0e4284a49c087608b545ab6bd990905fb61f3"}
```