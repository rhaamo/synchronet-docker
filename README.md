SynchroNET Docker image
=======================

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

# Environment

|Key|Default value|Description|
|---|-------------|-----------|
|SBBS_UID|1000|Runtime Synchronet User ID|
|SBBS_GID|1000|Runtime Synchronet Group ID|
|SBBS_INIT_NODES|6|Number of nodes to init by default|
|SBBS_INIT_NOCTRL|0|1 will leave the ctrl (a docker volume) empty|

# Volumes

|path|description|
|----|-----------|
|/home/synchronet/sbbs/data|Datas volume|
|/home/synchronet/sbbs/ctrl|Config volume|

# Versions

- 317b
