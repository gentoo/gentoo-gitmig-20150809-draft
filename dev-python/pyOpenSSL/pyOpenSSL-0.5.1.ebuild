# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyOpenSSL/pyOpenSSL-0.5.1.ebuild,v 1.11 2004/01/15 03:24:28 blauwers Exp $

inherit distutils

DESCRIPTION="Python interface to the OpenSSL library"
HOMEPAGE="http://pyopenssl.sourceforge.net/"
SRC_URI="mirror://sourceforge/pyopenssl/${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="x86"
IUSE="tetex"

RDEPEND="virtual/python
	>=dev-libs/openssl-0.9.6g"
DEPEND="${RDEPEND}
	tetex? ( >=dev-tex/latex2html-2002.2 )"

src_compile() {
	distutils_src_compile
	if [ "`use tetex`" ] ; then
		addwrite /var/cache/fonts
		cd ${S}/doc
		make html ps dvi
	fi
}

src_install() {
	distutils_src_install

	if [ "`use tetex`" ] ; then
		dohtml ${S}/doc/html/*
		dodoc ${S}/doc/pyOpenSSL.*
	fi

	# install examples
	docinto examples
	dodoc ${S}/examples/*
	docinto examples/simple
	dodoc ${S}/examples/simple/*
}

pkg_postinst() {
	echo
	einfo "For docs in html you need to have tetex in your USE var"
	echo
}
