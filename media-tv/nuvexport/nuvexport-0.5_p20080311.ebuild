# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nuvexport/nuvexport-0.5_p20080311.ebuild,v 1.1 2009/01/10 13:43:09 beandog Exp $

inherit eutils

DESCRIPTION="Export from mythtv recorded NuppelVideo files"
HOMEPAGE="http://www.forevermore.net/mythtv/"
SRC_URI="http://www.forevermore.net/files/nuvexport/nuvexport-0.5-0.20080311.svn.tar.bz2"
LICENSE="as-is"
SLOT="0"
IUSE=""
KEYWORDS="~amd64 ~ppc ~x86"
DEPEND=""
RDEPEND="dev-perl/DBI
	dev-perl/DBD-mysql
	dev-perl/DateManip
	media-video/ffmpeg
	media-video/mjpegtools
	media-video/transcode
	media-libs/id3lib
	media-video/mplayer
	=media-tv/mythtv-0.21*"

S="${WORKDIR}/nuvexport-0.5"

pkg_setup() {
	if ! built_with_use media-video/transcode mjpeg ; then
		eerror "media-video/transcode is missing mjpeg support. Please add"
		eerror "'mjpeg' to your USE flags, and re-emerge media-video/transcode."
		die "transcode needs mjpeg support"
	fi

	if ! built_with_use -a media-video/ffmpeg aac encode threads xvid; then
		eerror "media-video/ffmpeg is missing necessary support. Please add"
		eerror "'aac encode threads xvid' to your USE flags, and re-emerge"
		eerror "media-video/ffmpeg."
		die "ffmpeg needs USE='aac encode threads xvid'"
	fi
}

src_install() {
	einstall || die "einstall died"
}
