# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/m2crypto/m2crypto-0.12-r1.ebuild,v 1.5 2005/10/16 21:18:37 kloeri Exp $

inherit distutils

DESCRIPTION="A python wrapper for the OpenSSL crypto library"
HOMEPAGE="http://sandbox.rulemaker.net/ngps/m2/"
SRC_URI="http://sandbox.rulemaker.net/ngps/Dist/${P}.zip"

LICENSE="BSD"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND=">=dev-libs/openssl-0.9.7
		dev-lang/swig
		app-arch/unzip"

PYTHON_MODNAME="M2Crypto"

src_install () {
	DOCS="README SWIG BUGS CHANGES STORIES LICENCE"
	distutils_src_install
	# can't dodoc, doesn't handle subdirs
	dodir /usr/share/doc/${PF}/example
	cp -pPR demo/* ${D}/usr/share/doc/${PF}/example
	dohtml -r doc/*
}
