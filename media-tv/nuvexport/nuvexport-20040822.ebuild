# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nuvexport/nuvexport-20040822.ebuild,v 1.2 2004/11/30 22:07:55 swegener Exp $

S=${WORKDIR}/nuvexport
DESCRIPTION="Export from mythtv recorded NuppelVideo files"
HOMEPAGE="http://www.forevermore.net/mythtv/"
SRC_URI="http://forevermore.net/files/nuvexport-2004-08-22.tar.bz2"
LICENSE="as-is"
SLOT="0"

IUSE=""

KEYWORDS="~x86"
DEPEND=""
RDEPEND="dev-perl/DBI
	media-video/ffmpeg
	media-video/transcode
	media-video/mjpegtools
	media-tv/mythtv"

src_install() {
	dobin nuvexport nuvinfo
	insinto /usr/share/nuvexport
	doins *pm
}
