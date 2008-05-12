# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/m2crypto/m2crypto-0.16.ebuild,v 1.3 2008/05/12 07:44:11 hawking Exp $

inherit distutils portability eutils

MY_PV="${PV%.*}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="A python wrapper for the OpenSSL crypto library"
HOMEPAGE="http://wiki.osafoundation.org/bin/view/Projects/MeTooCrypto"
SRC_URI="http://wiki.osafoundation.org/pub/Projects/MeTooCrypto/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc x86"
IUSE="doc"

#S="${WORKDIR}/${MY_P}"

RDEPEND=">=dev-libs/openssl-0.9.7
	app-arch/unzip
	virtual/python
	doc? ( dev-python/epydoc )"
DEPEND="${RDEPEND}
	>=dev-lang/swig-1.3.25"

PYTHON_MODNAME="M2Crypto"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# apply patches
	#epatch "${FILESDIR}/${MY_P}-gentoo.patch"

	# convert swig %name syntax to %rename syntax
	# FIXME: doesn't work right now as expected. commented out for now.
	#sed -i -e "s:^%name(\([^ ]*\))[^/]* \*\?\([^ ]\+\)(.*);.*:%rename \2 \1;:g" SWIG/*.i

	# removing obsolete CVS dirs
	rm -rf $(find -name CVS -type d)
}

src_install() {
	DOCS="CHANGES INSTALL"
	distutils_src_install
	dohtml -r doc/*

	if use doc; then
		cd "${S}"/doc/
		epydoc --html --parse-only --output=api --name=M2Crypto M2Crypto
		dohtml -r "${S}-doc"/*
		cd "${S}"/demo && treecopy . "${D}/usr/share/doc/${PF}/example"
	fi
}
