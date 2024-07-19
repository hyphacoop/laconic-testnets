# How to Register an Authority via Auction

This guide demonstrates how to register an authority using `laconic-registry-cli` when authority auctions are enabled in the registry module.

### Prerequisites

* Start the `laconicd` and `laconic-registry-cli` containers using the script in the [How to Join](/devnet/README.md#how-to-join) section of the README.
* Obtain a private key in the format shown in [this guide](private-key.md).
* Configure a user key for `laconic-registry-cli` as shown in [this guide](configure-cli-key.md).
* Create a bond using [this guide](./create-bond.md)
* Configure the bond for `laconic-registry-cli` as shown in [this guide](./configure-cli-bond.md)

## Register an Authority

The authority registration process is as follows:
* An authority is reserved, which triggers an auction to start.
* Bids are committed up until the `commitsEndTime` is reached.
* Bids are revealed up until the `revealsEndTime` is reached.
* At the end of the reveals phase there is a winning address and bid.
* The winning address sets the bond for the auctioned authority.

### Reserve an authority

Start the auction.
```
laconic-so deployment --dir laconic-console-deployment exec cli "laconic registry authority reserve loro"
{"success": true}
```
Obtain the auction ID by querying the authority.
```
laconic-so deployment --dir laconic-console-deployment exec cli "laconic registry authority whois loro"
...
    "auction": {
      "id": "73e0b082a198c396009ce748804a9060c674a10045365d262c1584f99d2771c1",
...
```

### Commit a bid

Commit a bid to the auction while its status is listed as `commit` using the auction ID. A reveal file will be generated.
```
laconic-so deployment --dir laconic-console-deployment exec cli "laconic registry auction bid commit 73e0b082a198c396009ce748804a9060c674a10045365d262c1584f99d2771c1 5000000 photon --chain-id laconic_9000-1"
{"reveal_file":"/app/out/bafyreiewi4osqyvrnljwwcb36fn6sr5iidfpuznqkz52gxc5ztt3jt4zmy.json"}
```

### Reveal a bid

Reveal a bid to the auction while its status is listed as `reveal` using the auction ID and the reveal file generated from the bid commit.
```
laconic-so deployment --dir laconic-console-deployment exec cli "laconic registry auction bid reveal 73e0b082a198c396009ce748804a9060c674a10045365d262c1584f99d2771c1 /app/out/bafyreiewi4osqyvrnljwwcb36fn6sr5iidfpuznqkz52gxc5ztt3jt4zmy.json --chain-id laconic_9000-1"
```

### Register authority

Query the auction after the auction ends, it should list a `completed` status and a winner.
```
laconic-so deployment --dir laconic-console-deployment exec cli "laconic registry auction get 73e0b082a198c396009ce748804a9060c674a10045365d262c1584f99d2771c1"
```

Set the authority using a bond ID.
```
laconic-so deployment --dir laconic-console-deployment exec cli "laconic registry authority bond set loro fbea5d17b6a8b71c8e8fb971977b6cd2e1900621d8cbb0e463646f21d69b38ef"
{"success": true}
```

Verify the authority has been registered.
```
laconic-so deployment --dir laconic-console-deployment exec cli "laconic registry authority whois loro"
```