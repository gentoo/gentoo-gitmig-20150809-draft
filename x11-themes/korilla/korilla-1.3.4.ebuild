# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/korilla/korilla-1.3.4.ebuild,v 1.7 2005/08/03 18:23:53 gustavoz Exp $

inherit kde
need-kde 3

DESCRIPTION="Kool Gorilla Icon Set for KDE"
SRC_URI="http://www.starsurvivor.net/linux/gorilla/Korilla-v${PV}.tar.bz2"
KEYWORDS="x86 ppc sparc amd64"
IUSE=""
SLOT="0"
LICENSE="as-is"

# stripping hangs and we've no binaries
RESTRICT="$RESTRICT nostrip"

src_unpack() {
	unpack Korilla-v${PV}.tar.bz2
	mv "Kool.Gorilla" "${P}"
}

src_compile() {
	return 1
}

src_install(){
	dodir $PREFIX/share/icons/
	cp -r ${S} ${D}/${PREFIX}/share/icons/
}
