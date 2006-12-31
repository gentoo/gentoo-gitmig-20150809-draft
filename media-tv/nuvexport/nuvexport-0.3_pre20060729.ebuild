# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nuvexport/nuvexport-0.3_pre20060729.ebuild,v 1.6 2006/12/31 18:00:34 beandog Exp $

inherit eutils

S=${WORKDIR}/nuvexport-0.3
DESCRIPTION="Export from mythtv recorded NuppelVideo files"
HOMEPAGE="http://www.forevermore.net/mythtv/"
SRC_URI="http://www.forevermore.net/files/nuvexport/archive/nuvexport-0.3-0.20060729.svn.tar.bz2"
LICENSE="as-is"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"
DEPEND=""
RDEPEND="dev-perl/DBI
	dev-perl/DBD-mysql
	dev-perl/DateManip
	>=media-video/ffmpeg-0.4.9_p20050226-r1
	media-video/mjpegtools
	>=media-video/transcode-0.6.14
	media-libs/id3lib
	media-video/mplayer
	=media-tv/mythtv-0.19*"

pkg_setup() {
	if ! built_with_use media-video/transcode mjpeg ; then
		eerror "media-video/transcode is missing mjpeg support. Please add"
		eerror "'mjpeg' to your USE flags, and re-emerge media-video/transcode."
		die "transcode needs mjpeg support"
	fi

	if ! built_with_use media-video/ffmpeg aac encode threads xvid ; then
		eerror "media-video/ffmpeg is missing necessary support. Please add"
		eerror "'aac encode threads xvid' to your USE flags, and re-emerge"
		eerror "media-video/ffmpeg."
		die "ffmpeg needs USE='aac dvd encode threads xvid"
	fi
}

src_install() {
	einstall || die "failed to install"
}
