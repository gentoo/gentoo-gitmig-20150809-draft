# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/xmltex/xmltex-1.0.ebuild,v 1.12 2002/12/09 04:17:45 manson Exp $

MY_P="base"
S=${WORKDIR}/${MY_P}

DESCRIPTION="A namespace-aware XML parser written in Tex"
SRC_URI="ftp://ftp.tex.ac.uk/tex-archive/macros/xmltex/${MY_P}.tar.gz"
HOMEPAGE="http://users.ox.ac.uk/~rahtz/passivetex/"

KEYWORDS="x86 ppc sparc "
LICENSE="freedist"
SLOT="0"

DEPEND="app-text/tetex"

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
