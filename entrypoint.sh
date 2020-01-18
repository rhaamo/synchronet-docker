#!/usr/bin/env bash
#set -e -x

#echo "--- force fix rights (this can take time)"
#chown -R $SBBS_UID:$SBBS_GID /home/synchronet/

echo "--- running as `id`"

echo "--- init config"
if [ -f "/home/synchronet/sbbs/ctrl/.init" ]; then
	if [ -f "/home/synchronet/sbbs/ctrl/sbbs.ini" ]; then
		echo "--- detected sbbs.ini, aborting"
	else
		echo "--- copying defaults..."
		cp -vr /home/synchronet/sbbs/ctrl-base/* /home/synchronet/sbbs/ctrl/
		cp -vr /home/synchronet/sbbs/text-base/* /home/synchronet/sbbs/text/
		sed -i 's/;User=admin/User=synchronet/' /home/synchronet/sbbs/ctrl/sbbs.ini
		sed -i 's/;Group=wheel/Group=synchronet/' /home/synchronet/sbbs/ctrl/sbbs.ini
		rm -vf /home/synchronet/sbbs/ctrl/.init
		echo "--- done"
	fi
else
	echo "--- not needed"
fi

echo "--- run it"
exec "$@"
