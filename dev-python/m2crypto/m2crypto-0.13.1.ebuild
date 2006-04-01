# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/m2crypto/m2crypto-0.13.1.ebuild,v 1.3 2006/04/01 15:08:15 agriffis Exp $

inherit distutils portability eutils

MY_PV="${PV%.*}"
MY_P="${PN}-${MY_PV}"
MY_PPV="${PV%.*}p${PV##*.}"

DESCRIPTION="A python wrapper for the OpenSSL crypto library"
HOMEPAGE="http://sandbox.rulemaker.net/ngps/m2/"
SRC_URI="http://sandbox.rulemaker.net/ngps/Dist/${MY_P}.zip
	doc? ( http://sandbox.rulemaker.net/ngps/Dist/${MY_P}-apidoc.zip )
	http://sandbox.rulemaker.net/ngps/Dist/${MY_PPV}.patch"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="doc"

S="${WORKDIR}/${MY_P}"

DEPEND=">=dev-libs/openssl-0.9.7
	>=dev-lang/swig-1.3.21
	app-arch/unzip
	virtual/python"

PYTHON_MODNAME="M2Crypto"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# apply patches
	epatch "${DISTDIR}/${MY_PPV}.patch"
	epatch "${FILESDIR}/${MY_P}-gentoo.patch"

	# convert swig %name syntax to %rename syntax
	# FIXME: doesn't work right now as expected. commented out for now.
	#sed -i -e "s:^%name(\([^ ]*\))[^/]* \*\?\([^ ]\+\)(.*);.*:%rename \2 \1;:g" SWIG/*.i

	# removing obsolete CVS dirs
	rm -rf $(find -name CVS -type d)
}

src_install() {
	DOCS="BUGS CHANGES INSTALL doc/ZServerSSL-HOWTO"
	distutils_src_install
	dohtml -r doc/*

	if use doc; then
		dohtml -r "${S}-doc"/*
		cd demo && treecopy . "${D}/usr/share/doc/${PF}/example"
	fi
}
