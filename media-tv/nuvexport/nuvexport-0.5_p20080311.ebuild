# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nuvexport/nuvexport-0.5_p20080311.ebuild,v 1.3 2009/08/02 05:34:37 ssuominen Exp $

EAPI=2

DESCRIPTION="Export from mythtv recorded NuppelVideo files"
HOMEPAGE="http://www.forevermore.net/mythtv/"
SRC_URI="http://www.forevermore.net/files/${PN}/${PN}-0.5-0.20080311.svn.tar.bz2"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="dev-perl/DBI
	dev-perl/DBD-mysql
	dev-perl/DateManip
	media-video/ffmpeg[faac,encode,threads,xvid]
	media-video/mjpegtools
	media-video/transcode[mjpeg]
	media-libs/id3lib
	media-video/mplayer
	=media-tv/mythtv-0.21*"

S=${WORKDIR}/${PN}-0.5

src_install() {
	einstall || die "einstall failed"
}
