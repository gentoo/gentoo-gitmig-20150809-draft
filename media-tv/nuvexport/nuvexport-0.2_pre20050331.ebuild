# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nuvexport/nuvexport-0.2_pre20050331.ebuild,v 1.1 2005/04/01 07:40:12 cardoe Exp $

S=${WORKDIR}/nuvexport-0.2
DESCRIPTION="Export from mythtv recorded NuppelVideo files"
HOMEPAGE="http://www.forevermore.net/mythtv/"
SRC_URI="http://www.forevermore.net/files/nuvexport/nuvexport-0.2-0.20050331.cvs.tar.bz2
	http://www.forevermore.net/files/nuvexport/archive/nuvexport-0.2-0.20050331.cvs.tar.bz2"
LICENSE="as-is"
SLOT="0"

IUSE=""

KEYWORDS="~x86"
DEPEND=""
RDEPEND="dev-perl/DBI
	dev-perl/DBD-mysql
	>=media-video/ffmpeg-0.4.9_p20050226-r1
	media-video/mjpegtools
	>=media-video/transcode-0.6.14
	media-video/avidemux
	media-video/lve
	media-libs/id3lib
	media-video/mplayer
	|| ( media-tv/mythtv media-tv/mythfrontend )"

pkg_setup() {
	local trans_use="$(</var/db/pkg/`best_version media-video/transcode`/USE)"
	if ! has mjpeg ${trans_use} ; then
		eerror "media-video/transcode is missing mjpeg support. Please add"
		eerror "'mjpeg' to your USE flags, and re-emerge media-video/transcode."
		die "transcode needs mjpeg support"
	fi

	local ffmpeg_use="$(</var/db/pkg/`best_version media-video/ffmpeg`/USE)"
	ffmpeg_need="aac dvd encode threads xvid"
	for flag in ${ffmpeg_need} ; do
		if ! has ${flag} ${ffmpeg_use} ; then
			eerror "media-video/ffmpeg is missing ${flag} support. Please add"
			eerror "'${flag}' to your USE flags, and re-emerge media-video/ffmpeg."
			die "ffmpeg needs ${flag} support"
		fi
	done

	if has pic ${ffmpeg_use} ; then
		ewarn "You have 'pic' enabled in your USE for your ffmpeg build. This is NOT"
		ewarn "recommended as it will hurt your performance badly. Only use this if"
		ewarn "necessary for your arch."
	fi
}

src_install() {
	einstall || die "failed to install"
}
