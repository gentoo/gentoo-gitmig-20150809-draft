# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nuvexport/nuvexport-20040411.ebuild,v 1.2 2004/06/25 00:33:13 agriffis Exp $

S=${WORKDIR}/nuvexport
DESCRIPTION="Export from mythtv recorded NuppelVideo files"
HOMEPAGE="http://www.forevermore.net/mythtv/"
SRC_URI="http://forevermore.net/mythtv/files/nuvexport-2004-04-11.tar.bz2"
LICENSE="as-is"
SLOT="0"

IUSE=""

KEYWORDS="~x86"
DEPEND=""
RDEPEND="DBI ffmpeg transcode mjpegtools mythtv"

src_install() {
	dobin nuvexport nuvinfo
	insinto /usr/share/nuvexport
	doins *pm
}
