# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/imhangul_status_applet/imhangul_status_applet-0.2.ebuild,v 1.1 2003/01/24 11:35:45 jayskwak Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Status Applet for imhangul"
HOMEPAGE="http://imhangul.kldp.net/"
SRC_URI="http://download.kldp.net/imhangul/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=app-i18n/imhangul-0.9.4"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man || die "./configure failed"
	
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	dodoc AUTHORS ChangeLog INSTALL NEWS README
}
