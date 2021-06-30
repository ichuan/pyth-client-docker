# pyth-client-docker
Dockerfile for pyth-client (<https://github.com/pyth-network/pyth-client>). Python3.8 included.


# Running

Customize config file `coin.conf` first.

```bash
# setup key-store directory
mkdir keys
docker run --rm -it -v `pwd`/keys:/keys mixhq/pyth-client pyth init_key -k /keys

# extract public key
docker run --rm -it -v `pwd`/keys:/keys mixhq/pyth-client pyth get_pub_key /keys/publish_key_pair.json

# initialize three additional public keys in the key-store (for pythnet)
docker run --rm -it -v `pwd`/keys:/keys mixhq/pyth-client /opt/pctest/init_key_store.sh pythnet /keys

# test publish (using pythnet env ip: 44.232.27.44)
docker run --rm -it -v `pwd`/keys:/keys mixhq/pyth-client test_publish -k /keys -r 44.232.27.44 -t 44.232.27.44

# start pythd server (for the purpose of using test_publish.py to publish)
docker run --rm -it -v `pwd`/keys:/keys mixhq/pyth-client pythd -k /keys -r 44.232.27.44 -t 44.232.27.44

# test test_publish.py (through pythd)
docker run --rm -it -v `pwd`/keys:/keys mixhq/pyth-client /opt/pctest/test_publish.py

# running pyth_tx server
docker run --rm -it -v `pwd`/keys:/keys mixhq/pyth-client pyth_tx -r <ip_of_solana_validator_node>

# running dashboard
docker run --rm -it -v `pwd`/keys:/keys mixhq/pyth-client pythd -k /keys -r 44.232.27.44 -w /opt/dashboard
```
