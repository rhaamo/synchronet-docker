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

echo "--- init default config"
if [ "$SBBS_INIT_NOCTRL" -eq "1" ]; then
	echo "--- ctrl will not be touched as SBBS_INIT_NOCTRL=$SBBS_INIT_NOCTRL"
else
	if [ -f "ctrl/sbbs.ini" ]; then
		echo "--- ctrl/sbbs.ini already exists, not doing anything"
	else
		cp -r ctrl-base/* ctrl/
		echo "--- deployed default config to ctrl volume"
	fi
fi

echo "--- force fix rights (this can take time)"
chown -R $SBBS_UID:$SBBS_GID /home/synchronet

echo "--- run it"
exec "$@"
