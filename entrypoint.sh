#!/usr/bin/env bash
set -e -x

echo "--- init nodes 1 to $SBBS_INIT_NODES"
nnode=1
maxnodes=$SBBS_INIT_NODES
while [ "$nnode" -le "$maxnodes" ]; do
	if [ ! -d "node$nnode" ]; then
		cp -r node1 node$nnode
		echo "--- created node node$nnode"
	else
		echo "--- node node$nnode already created"
	fi
	nnode=`expr "$nnode" + 1`
done

#echo "--- force fix rights (this can take time)"
#chown -R $SBBS_UID:$SBBS_GID /home/synchronet

echo "--- run it"
exec "$@"
