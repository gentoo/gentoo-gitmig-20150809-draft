# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-tv/nuvexport/nuvexport-20041022.ebuild,v 1.1 2004/10/26 14:50:38 kanaka Exp $

S=${WORKDIR}/nuvexport
DESCRIPTION="Export from mythtv recorded NuppelVideo files"
HOMEPAGE="http://www.forevermore.net/mythtv/"
SRC_URI="http://forevermore.net/files/nuvexport-2004-10-22.tar.bz2"
LICENSE="as-is"
SLOT="0"

IUSE=""

KEYWORDS="~x86"
DEPEND=""
RDEPEND="DBI ffmpeg transcode mjpegtools mythtv"

src_install() {
	make install BINDIR=$D/usr/bin MANDIR=$D/usr/share/man/man1 \
		MODDIR=$D/usr/share/nuvexport || die "install failed"
}
