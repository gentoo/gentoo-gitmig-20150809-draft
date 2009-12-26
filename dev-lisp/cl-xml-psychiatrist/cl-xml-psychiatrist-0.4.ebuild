# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-xml-psychiatrist/cl-xml-psychiatrist-0.4.ebuild,v 1.5 2009/12/26 17:34:09 pva Exp $

inherit common-lisp

DESCRIPTION="A powerful XML sanity checker for Common Lisp"
HOMEPAGE="http://common-lisp.net/project/xml-psychiatrist/"
SRC_URI="http://common-lisp.net/project/xml-psychiatrist/xml-psychiatrist-${PV}.tar.gz"
LICENSE="LLGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE="doc"

DEPEND="dev-lisp/cl-xmls
	dev-lisp/cl-ppcre
	doc? ( dev-tex/latex2html app-text/ghostscript-gpl )"

CLPACKAGE=xml-psychiatrist

S=${WORKDIR}/xml-psychiatrist-${PV}

src_compile() {
	if use doc; then
		cd doc
		latex manual.tex
		dvips manual.dvi -o manual.ps
		ps2pdf manual.ps
		latex2html manual.tex
	fi
}

src_install() {
	common-lisp-install *.asd *.lisp
	common-lisp-system-symlink
	dodoc README
	if use doc; then
		cd doc
		dohtml manual/*
		dodoc manual.{ps,pdf}
	fi
}
