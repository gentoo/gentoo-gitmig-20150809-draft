# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rio/rio-1.0.7.ebuild,v 1.3 2003/09/05 12:14:10 msterret Exp $

DESCRIPTION="Utility for the Diamond Rio 300 portable MP3 player"
SRC_URI="http://www.world.co.uk/sba/${PN}007.tgz"
HOMEPAGE="http://www.world.co.uk/sba/rio.html"

SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

DEPEND="virtual/glibc"
RDEPEND=""

UNPACKDIR=rio107

S=${WORKDIR}/${UNPACKDIR}

src_compile() {
	emake || die
}

src_install() {
	into /usr
	dobin rio
	dodoc CREDITS README gpl.txt playlist.txt rio.txt
}

pkg_postinst() {
	einfo
	einfo "Warning! The /usr/bin/rio binary is installed SUID/GUID root."
	einfo
}
