# How to Obtain a Private Key

You will need a private key to use the `laconic-registry-cli` tool.

* List the keys in the keyring. For a container set up with a `fixturenet-laconicd-deployment` directory, we can list the keys this way:
   ```
   laconic-so deployment --dir fixturenet-laconicd-deployment exec laconicd "laconicd keys list"
   - address: laconic1d2vkkn9r2gumr8qkx3hf4zzkufmv8k5k8tdryp
     name: alice
     pubkey: '{"@type":"/cosmos.crypto.secp256k1.PubKey","key":"AlLWUQeuUosMjUiUcv2yTO6/tliU3usEdDPahGYOCVQb"}'
     type: local
   ```
* Export the unarmored hex using the account name.
   ```
   laconic-so deployment --dir fixturenet-laconicd-deployment exec laconicd "laconicd keys export alice --unarmored-hex --unsafe"
   WARNING: The private key will be exported as an unarmored hexadecimal string. USE AT YOUR OWN RISK. Continue? [y/N]: y
   bf48223*
   ```
The `bf48223...` sequence is the private key.
