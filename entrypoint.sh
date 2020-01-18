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

echo "--- init config"
if [ -f "/home/synchronet/sbbs/ctrl/.init" ]; then
	if [ -f "/home/synchronet/sbbs/ctrl/sbbs.ini" ]; then
		echo "--- detected sbbs.ini, aborting"
	else
		echo "--- copying defaults..."
		cp -vr /home/synchronet/sbbs/ctrl-base/* /home/synchronet/sbbs/ctrl/
		cp -vr /home/synchronet/sbbs/text-base/* /home/synchronet/sbbs/text/
		echo "--- done"
	fi
else
	echo "--- not needed"
fi

#echo "--- force fix rights (this can take time)"
#chown -R $SBBS_UID:$SBBS_GID /home/synchronet

echo "--- run it"
exec "$@"
