# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/rio/rio-1.0.7.ebuild,v 1.8 2004/06/28 04:10:11 vapier Exp $

DESCRIPTION="Utility for the Diamond Rio 300 portable MP3 player"
HOMEPAGE="http://www.world.co.uk/sba/rio.html"
SRC_URI="http://www.world.co.uk/sba/${PN}007.tgz"

KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"
IUSE=""

DEPEND="virtual/libc"
RDEPEND=""

S=${WORKDIR}/${UNPACKDIR}

src_compile() {
	emake || die "compile failed"
}

src_install() {
	dobin rio || die
	dodoc CREDITS README gpl.txt playlist.txt rio.txt
}

pkg_postinst() {
	einfo "Warning! The /usr/bin/rio binary is installed SUID/GUID root."
}
