# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/msn4lin/msn4lin-0.4f.ebuild,v 1.1 2003/05/19 19:12:50 mholzer Exp $

S=${WORKDIR}/${MY_P}
MY_P=${PN}-tcl
DESCRIPTION="Tcl/tk MSN Messenger client for linux"

SRC_URI="mirror://sourceforge/${PN}/${MY_P}-${PV}.tar.gz"
HOMEPAGE="http://msn4lin.sourceforge.net/"
DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3"
	
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

src_unpack() {
    unpack ${A}
    cd ${S}
    patch -p0 < ${FILESDIR}/${P}-gentoo.diff
}

src_install() {

	cd ${S}
	dodir /usr/share/msn4lin-tcl
	dodir /usr/bin
	dodoc GNUGPL agradecimientos.txt leeme.txt original.txt
	cp -rf * ${D}/usr/share/msn4lin-tcl/
	cd ${D}/usr/share/msn4lin-tcl/
	# We disable all this auto-update stuff..
	echo "#!/bin/sh" > comprobar
	echo "#!/bin/sh" > actualizar
	ln -sf /usr/share/msn4lin-tcl/msn4lin ${D}/usr/bin/msn4lin
	
}
