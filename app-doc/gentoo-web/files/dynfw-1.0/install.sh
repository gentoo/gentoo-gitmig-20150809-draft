if [ "$PREFIX" = "" ]
then
	export PREFIX="/usr/local"
fi
if [ ! -d ${PREFIX}/share ]
then
	echo "Error: ${PREFIX}/share doesn't exist."
	exit 1
fi
for x in ipblock ipdrop tcplimit host-tcplimit user-outblock 
#webzap
do
	cat ${x} | sed -e "s:##PREFIX##:${PREFIX}:g" ${x} > ${PREFIX}/sbin/${x}
	chown 0.0 ${PREFIX}/sbin/${x}
	chmod 0755 ${PREFIX}/sbin/${x}
done
install -m0755 dynfw.sh ${PREFIX}/share
echo "Gentoo Linux Dynamic Firewall Tools installed."
