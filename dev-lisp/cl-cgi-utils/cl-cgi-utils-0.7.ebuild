# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lisp/cl-cgi-utils/cl-cgi-utils-0.7.ebuild,v 1.2 2008/09/03 20:54:16 opfer Exp $

inherit common-lisp eutils

DESCRIPTION="lisp-cgi-utils is a Common Lisp library for developing CGI applications."
HOMEPAGE="http://www.thangorodrim.de/software/lisp-cgi-utils/index.html"
SRC_URI="http://www.thangorodrim.de/software/lisp-cgi-utils/lisp-cgi-utils-${PV}.tar.gz"
LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ppc ~sparc x86"
IUSE="doc"

CLPACKAGE=lisp-cgi-utils

DEPEND="doc? ( virtual/latex-base dev-tex/hevea )"

S=${WORKDIR}/lisp-cgi-utils-${PV}

src_unpack() {
	unpack ${A}
	epatch "${FILESDIR}/${PV}-dont-print-during-make-gentoo.patch"
	epatch "${FILESDIR}/${PV}-defconstant-gentoo.patch"
}

src_compile() {
	if use doc; then
		make -C doc || die
	fi
}

src_install() {
	common-lisp-install *.{lisp,asd}
	common-lisp-system-symlink
	dodoc LGPL-2.1
	insinto /usr/share/doc/${PF}/examples
	doins examples/*
	use doc && dodoc doc/{examples,cookies}.{dvi,ps,pdf,html,txt}
}
