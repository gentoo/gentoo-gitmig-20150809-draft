# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-albert/cl-albert-0.4.9.ebuild,v 1.4 2005/02/08 19:03:04 mkennedy Exp $

inherit common-lisp

DESCRIPTION="Albert is a documentation-generator for Common Lisp, comparable to Javadoc and Doxygen. Currently it generates DocBook documentation. It reads an ASDF system definition and documents the system."
HOMEPAGE="http://albert.sourceforge.net/"
SRC_URI="mirror://sourceforge/albert/${P/cl-/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	app-text/docbook-dsssl-stylesheets
	virtual/commonlisp"

CLPACKAGE=albert

S=${WORKDIR}/${P/cl-/}

src_compile() {
	make -C expat all || die
}

src_install() {
	for p in . apispec base lisp2csf specs spres tools ; do
		insinto /usr/share/common-lisp/source/${CLPACKAGE}/${p}
		doins ${p}/*.lisp
	done
	insinto /usr/share/common-lisp/source/${CLPACKAGE}
	doins *.asd
	common-lisp-system-symlink
	dodoc COPYING README ChangeLog THANKS
	dohtml web/*
	dobin expat/alb_xml2sexp
	doman expat/alb_xml2sexp.1

	insinto /usr/share/albert
	doins data/*
	insinto /usr/share/albert/icons
	doins data/icons/*
	insinto /usr/share/albert/apis
	doins data/apis
}

pkg_preinst() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}

pkg_postrm() {
	rm -rf /usr/lib/common-lisp/*/${CLPACKAGE} || true
}
