SynchroNET Docker image
=======================

# Build arguments
Uses `VERSION` (like `317b`) to build a specific version of SynchroNet.

# Environment

|Key|Default value|Description|
|SBBS_UID|1000|Runtime Synchronet User ID|
|SBBS_GID|1000|Runtime Synchronet Group ID|
|SBBS_INIT_NODES|6|Number of nodes to init by default|
|SBBS_INIT_NOCTRL|0|1 will leave the ctrl (a docker volume) empty|

# Volumes

|path|description|
|/home/synchronet/sbbs/data|Datas volume|
|/home/synchronet/sbbs/ctrl|Config volume|
