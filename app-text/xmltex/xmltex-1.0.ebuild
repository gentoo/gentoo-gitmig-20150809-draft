# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-text/xmltex/xmltex-1.0.ebuild,v 1.8 2002/09/18 19:47:09 raker Exp $

MY_P="base"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A namespace-aware XML parser written in Tex"
SRC_URI="ftp://ftp.tex.ac.uk/tex-archive/macros/xmltex/${MY_P}.tar.gz"
HOMEPAGE="http://users.ox.ac.uk/~rahtz/passivetex/"

KEYWORDS="x86 sparc sparc64"
LICENSE="freedist"
SLOT="0"

DEPEND="app-text/tetex"
RDEPEND="${DEPEND}"

src_compile() {

	cp ${FILESDIR}/${P}-Makefile Makefile

	make || die

}

src_install () {

	make DESTDIR=${D} install || die

	dodir /usr/bin
	cd ${D}/usr/bin
	ln -sf /usr/bin/virtex xmltex
	ln -sf /usr/bin/pdfvirtex pdfxmltex

}

pkg_postinst() {

	if [ -e /usr/bin/mktexlsr ]
	then
		/usr/bin/mktexlsr
	fi

}
