# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nuvexport/nuvexport-0.2_pre20050123.ebuild,v 1.1 2005/01/24 19:07:24 cardoe Exp $

S=${WORKDIR}/nuvexport-0.2
DESCRIPTION="Export from mythtv recorded NuppelVideo files"
HOMEPAGE="http://www.forevermore.net/mythtv/"
SRC_URI="http://www.forevermore.net/files/nuvexport/nuvexport-0.2-cvs20050123.tar.bz2"
LICENSE="as-is"
SLOT="0"

IUSE=""

KEYWORDS="~x86"
DEPEND=""
RDEPEND="dev-perl/DBI
	dev-perl/DBD-mysql
	media-video/ffmpeg
	media-video/mjpegtools
	media-video/transcode
	|| ( media-tv/mythtv media-tv/mythtv-cvs )"

src_install() {
	einstall || die "failed to install"
}
