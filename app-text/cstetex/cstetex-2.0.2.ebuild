# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cstetex/cstetex-2.0.2.ebuild,v 1.2 2004/02/01 15:31:07 usata Exp $

inherit tetex

DESCRIPTION="a complete TeX distribution with Czech and Slovak support"
HOMEPAGE="http://math.feld.cvut.cz/olsak/cstex/"

CSTEX="csfonts.tar.gz csplain.tar.gz cslatex.tar.gz cspsfonts.tar.gz csfonts-t1.tar.gz"
ENCTEX="enctex.tar.gz"

SRC_URI="${SRC_URI} ftp://math.feld.cvut.cz/pub/olsak/enctex/${ENCTEX}"
for FILE in ${CSTEX}; do
	SRC_URI="${SRC_URI} ftp://math.feld.cvut.cz/pub/cstex/base/${FILE}"
done

KEYWORDS="x86"

src_unpack() {

	tetex_src_unpack

	cd ${S}
	for FILE in ${CSTEX}; do
		unpack ${FILE}
	done
	epatch ${FILESDIR}/${P}.diff
	cd ${S}/texk/web2c
	unpack ${ENCTEX}
	epatch enctex/enctex.patch-to-7.5
}

src_install() {

	tetex_src_install

	einfo "Installing Czech files..."
	dodir /usr/share/texmf/tex/enctex
	cd ${S}
	cp -v texk/web2c/enctex/*.tex ${D}/usr/share/texmf/tex/enctex
}

pkg_postrm() {

	if [ ! -f /usr/bin/tex ] ; then
		for i in cslatex csplain pdfcslatex pdfcsplain; do
			rm /usr/bin/$i
		done
	fi
}
