# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-pdf/cl-pdf-110.ebuild,v 1.1 2005/12/31 08:14:27 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="CL-PDF is a cross-platform Common Lisp library for generating PDF files"
HOMEPAGE="http://www.fractalconcept.com/asp/BCg/sdataQ0709qxv9wpLDM==/sdataQucgleAq9b=="
SRC_URI="mirror://gentoo/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~ppc ~x86"
IUSE=""

DEPEND="dev-lisp/cl-salza
	dev-lisp/cl-iterate"

CLPACKAGE="cl-pdf cl-pdf-parser"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${PV}-gentoo.patch || die
}

src_install() {
	dodir $CLSYSTEMROOT
	insinto $CLSOURCEROOT/cl-pdf
	doins *.{lisp,asd}
	dosym $CLSOURCEROOT/cl-pdf/cl-pdf.asd $CLSYSTEMROOT/cl-pdf.asd
	dosym $CLSOURCEROOT/cl-pdf/cl-pdf-parser.asd $CLSYSTEMROOT/cl-pdf-parser.asd
	insinto /usr/share/fonts/afm
	doins afm/*.afm
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
	insinto /usr/share/doc/${PF}/contrib
	doins contrib/*
	dodoc *.txt
}
