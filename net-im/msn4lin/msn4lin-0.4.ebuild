# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Mantainer: Pau Oliva <pau@eSlack.org>
# /space/gentoo/cvsroot/gentoo-x86/net-im/msn4lin/msn4lin-0.2e.ebuild,v 1.1 2002/04/24 20:52:37 verwilst Exp

S=${WORKDIR}/${P}
DESCRIPTION="Tcl/tk MSN Messenger client for linux"

SRC_URI="http://www.ibiblio.org/gentoo/distfiles/${P}.tar.gz"
HOMEPAGE="http://www.borsanza.com/"
DEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3"
SLOT="0"

src_unpack() {
    unpack ${P}.tar.gz
    cd ${S}
    patch -p0 < ${FILESDIR}/${P}-gentoo.diff
}

src_install() {

	cd ${S}
	mkdir -p ${D}/usr/share/msn4lin
	mkdir -p ${D}/usr/bin
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


