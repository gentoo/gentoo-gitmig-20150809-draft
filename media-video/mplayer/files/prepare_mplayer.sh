#!/bin/sh
VERSION=$(date +%Y%m%d)
PACKAGE="mplayer-1.0_rc4_p${VERSION}"

svn checkout svn://svn.mplayerhq.hu/mplayer/trunk ${PACKAGE}

pushd ${PACKAGE} > /dev/null
	# ffmpeg is in git now so no svn external anymore
	rm -rf ffmpeg
	git clone git://git.ffmpeg.org/ffmpeg.git
	STORE_VERSION=$(svn log -r HEAD -q |grep ^r |cut -d' ' -f1)
	echo "*** Remember to adjust mplayer ebuild with revision: \"SVN-${STORE_VERSION}\" ***"
popd > /dev/null

find "${PACKAGE}" -type d -name '.svn' -prune -print0 | xargs -0 rm -rf
find "${PACKAGE}" -type d -name '.git' -prune -print0 | xargs -0 rm -rf

tar cJf ${PACKAGE}.tar.xz ${PACKAGE}
rm -rf ${PACKAGE}/

echo "Tarball: \"${PACKAGE}.tar.xz\""

echo "** all done **"
