# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/msn4lin/msn4lin-0.4.ebuild,v 1.8 2004/07/15 00:17:35 agriffis Exp $

DESCRIPTION="Tcl/tk MSN Messenger client for linux"

SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.borsanza.com/"
DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"
IUSE=""

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	patch -p0 < ${FILESDIR}/${P}-gentoo.diff
}

src_install() {

	cd ${S}
	dodir /usr/share/msn4lin
	dodir /usr/bin
	rm -f lang/languages
	cp ${FILESDIR}/languages-${PV} lang/languages
	dodoc GNUGPL agradecimientos.txt leeme.txt original.txt
	cp -rf * ${D}/usr/share/msn4lin/
	cd ${D}/usr/share/msn4lin/
	# We disable all this auto-update stuff..
	echo "#!/bin/sh" > comprobar
	echo "#!/bin/sh" > actualizar
	ln -sf /usr/share/msn4lin/msn4lin ${D}/usr/bin/msn4lin

}
