# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-albert/cl-albert-0.4.10.ebuild,v 1.5 2005/09/08 21:55:09 mkennedy Exp $

inherit common-lisp eutils

DESCRIPTION="Albert is a documentation-generator for Common Lisp, comparable to Javadoc and Doxygen. Currently it generates DocBook documentation. It reads an ASDF system definition and documents the system."
HOMEPAGE="http://albert.sourceforge.net/"
SRC_URI="mirror://sourceforge/albert/${P/cl-/}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86 ~ppc"
IUSE=""
DEPEND="dev-lisp/common-lisp-controller
	app-text/docbook-dsssl-stylesheets
	virtual/commonlisp"

CLPACKAGE=albert

S=${WORKDIR}/${P/cl-/}

src_unpack() {
	unpack ${A}
	find ${S} -type f -print0 | xargs -0 sed -i 's,simple-base-string,simple-string,i' || die
}

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
