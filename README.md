SynchroNET Docker image
=======================

# Important config notes
By default this image builds and assume synchronet will runs under the `synchronet` user and group (both UID/GID are 1000 by default), you will probably needs to adapt your config file.

Synchronet build, and run directory, is `/home/synchronet/sbbs`, `ctrl` and `data` directories are exposed `VOLUMES`.

http://wiki.synchro.net/config:nix

# Build
Uses `VERSION` (like `317b`) to build a specific version of SynchroNet.

```
docker image build -t synchronet:latest .
```

Specific version:
```
docker image build --build-arg VERSION=317b -t synchronet:317b .
```

# Run

```
docker run -d --name synchronet \
	-v /sbbs/data:/home/synchronet/sbbs/data \
	-v /sbbs/ctrl:/home/synchronet/sbbs/ctrl \
	synchronet:latest
```

# Initial config
Assuming you are using dedicated volumes for thoses three, you need to copy back the default values, or uses your own.

Get inside the container:
```
docker exec -it synchronet /bin/bash
```

Then in the container, copy the default values:
```
cp -r ctrl-base/* ctrl/
cp -r text-base/* text/
exit
```

# Environment

|Key|Default value|Description|
|---|-------------|-----------|
|SBBS_UID|1000|Runtime Synchronet User ID|
|SBBS_GID|1000|Runtime Synchronet Group ID|
|SBBS_INIT_NODES|6|Number of nodes to init by default|

# Volumes

|path|description|
|----|-----------|
|/home/synchronet/sbbs/data|Datas volume|
|/home/synchronet/sbbs/ctrl|Config volume|
|/home/synchronet/sbbs/text|Text volume|

# Versions

- 317b
