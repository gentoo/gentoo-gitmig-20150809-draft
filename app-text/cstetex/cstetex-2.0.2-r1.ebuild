# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/cstetex/cstetex-2.0.2-r1.ebuild,v 1.3 2005/04/05 17:11:42 usata Exp $

inherit tetex-2

IUSE=""
DESCRIPTION="a complete TeX distribution with Czech and Slovak support"
HOMEPAGE="http://math.feld.cvut.cz/olsak/cstex/"

CSTEX="csfonts.tar.gz csplain.tar.gz cslatex.tar.gz cspsfonts.tar.gz csfonts-t1.tar.gz"
ENCTEX="enctex.tar.gz"
SRC_URI="${SRC_URI} ftp://math.feld.cvut.cz/pub/olsak/enctex/${ENCTEX}"
for FILE in ${CSTEX}; do
	SRC_URI="${SRC_URI} ftp://math.feld.cvut.cz/pub/cstex/base/${FILE}"
done

KEYWORDS="x86 ~amd64"

src_unpack() {
	tetex-2_src_unpack

	cd ${S}
	for FILE in ${CSTEX}; do
		unpack ${FILE}
	done
	epatch ${FILESDIR}/${P}.diff
	cd ${S}/texk/web2c
	unpack ${ENCTEX}
	epatch enctex/enctex.patch-to-7.5

	# bug 75801
	EPATCH_OPTS="-d ${S}/libs/xpdf/xpdf -p0" epatch ${FILESDIR}/xpdf-CESA-2004-007-xpdf2-newer.diff
	EPATCH_OPTS="-d ${S}/libs/xpdf -p1" epatch ${FILESDIR}/xpdf-goo-sizet.patch
	EPATCH_OPTS="-d ${S}/libs/xpdf -p1" epatch ${FILESDIR}/xpdf2-underflow.patch
	EPATCH_OPTS="-d ${S}/libs/xpdf/xpdf -p0" epatch ${FILESDIR}/xpdf-3.00pl2-CAN-2004-1125.patch
	EPATCH_OPTS="-d ${S}/libs/xpdf/xpdf -p0" epatch ${FILESDIR}/xpdf-3.00pl3-CAN-2005-0064.patch
	EPATCH_OPTS="-d ${S} -p1" epatch ${FILESDIR}/xdvizilla.patch
}

src_install() {
	tetex-2_src_install

	einfo "Installing Czech files..."
	dodir /usr/share/texmf/tex/enctex
	cd ${S}
	cp -v texk/web2c/enctex/*.tex ${D}/usr/share/texmf/tex/enctex
}

pkg_postrm() {
	if [ ! -f ${ROOT}/usr/bin/tex ] ; then
		for i in cslatex csplain pdfcslatex pdfcsplain; do
			rm ${ROOT}/usr/bin/$i
		done
	fi
}
