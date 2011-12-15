#!/bin/sh
VERSION=$(date +%Y%m%d)
PACKAGE="mplayer-1.0_rc4_p${VERSION}"
DUMP_FFMPEG="$(dirname $0)/dump_ffmpeg.sh"

svn checkout svn://svn.mplayerhq.hu/mplayer/trunk ${PACKAGE}

pushd ${PACKAGE} > /dev/null
	# ffmpeg is in git now so no svn external anymore
	rm -rf ffmpeg
	git clone git://git.videolan.org/ffmpeg.git ffmpeg/
        sh "$DUMP_FFMPEG"
	STORE_VERSION=$(svn log -r HEAD -q |grep ^r |cut -d' ' -f1)
	echo "*** Remember to adjust mplayer ebuild with revision: \"SVN-${STORE_VERSION}\" ***"
popd > /dev/null

find "${PACKAGE}" -type d -name '.svn' -prune -print0 | xargs -0 rm -rf
find "${PACKAGE}" -type d -name '.git' -prune -print0 | xargs -0 rm -rf

tar cJf ${PACKAGE}.tar.xz ${PACKAGE}
rm -rf ${PACKAGE}/

echo "Tarball: \"${PACKAGE}.tar.xz\""

echo "** all done **"
