# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nuvexport/nuvexport-0.3_pre20060424.ebuild,v 1.2 2006/04/29 15:52:00 cardoe Exp $

inherit eutils

S=${WORKDIR}/nuvexport-0.3
DESCRIPTION="Export from mythtv recorded NuppelVideo files"
HOMEPAGE="http://www.forevermore.net/mythtv/"
SRC_URI="http://www.forevermore.net/files/nuvexport/nuvexport-0.3-0.20060424.svn.tar.bz2
	http://www.forevermore.net/files/nuvexport/archive/nuvexport-0.3-0.20060424.svn.tar.bz2"
LICENSE="as-is"
SLOT="0"

IUSE=""

RESTRICT="nomirror"
KEYWORDS="~amd64 ~ppc ~x86"
DEPEND=""
RDEPEND="dev-perl/DBI
	dev-perl/DBD-mysql
	dev-perl/DateManip
	>=media-video/ffmpeg-0.4.9_p20050226-r1
	media-video/mjpegtools
	>=media-video/transcode-0.6.14
	media-video/avidemux
	media-video/lve
	media-libs/id3lib
	media-video/mplayer
	media-tv/mythtv"

pkg_setup() {
	if ! built_with_use media-video/transcode mjpeg ; then
		eerror "media-video/transcode is missing mjpeg support. Please add"
		eerror "'mjpeg' to your USE flags, and re-emerge media-video/transcode."
		die "transcode needs mjpeg support"
	fi

	ffmpeg_need="aac dvd encode threads xvid"
	for flag in ${ffmpeg_need} ; do
		if ! built_with_use media-video/ffmpeg ${flag} ; then
			eerror "media-video/ffmpeg is missing ${flag} support. Please add"
			eerror "'${flag}' to your USE flags, and re-emerge media-video/ffmpeg."
			die "ffmpeg needs ${flag} support"
		fi
	done

	if built_with_use media-video/ffmpeg pic ; then
		ewarn "You have 'pic' enabled in your USE for your ffmpeg build. This is NOT"
		ewarn "recommended as it will hurt your performance badly. Only use this if"
		ewarn "necessary for your arch."
	fi
}

src_install() {
	einstall || die "failed to install"
}
