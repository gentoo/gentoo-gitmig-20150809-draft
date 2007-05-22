modprobe realmagic84xx >/dev/null 2>&1

if [ -n "${EM84XX_DVD_DRIVE}" ]; then
	modprobe packetcommand >/dev/null 2>&1
	for minor in 0 1 2 3; do
		mknod /dev/dvdpc${minor} c 123 ${minor}
		chown vdr:vdr /dev/dvdpc${minor}
	done
	export USE_DRIVE="${EM84XX_DVD_DRIVE}"
fi

