# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/m2crypto/m2crypto-0.20.2.ebuild,v 1.14 2010/12/26 14:48:30 arfrever Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
DISTUTILS_SRC_TEST="setup.py"

inherit distutils eutils

MY_PN="M2Crypto"

DESCRIPTION="A python wrapper for the OpenSSL crypto library"
HOMEPAGE="http://chandlerproject.org/bin/view/Projects/MeTooCrypto http://pypi.python.org/pypi/M2Crypto"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="doc"

RDEPEND=">=dev-libs/openssl-0.9.8"
DEPEND="${RDEPEND}
	>=dev-lang/swig-1.3.25
	doc? ( dev-python/epydoc )
	dev-python/setuptools"
RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}/${MY_PN}-${PV}"

DOCS="CHANGES"
PYTHON_MODNAME="${MY_PN}"

src_prepare() {
	distutils_src_prepare
	epatch "${FILESDIR}/${P}-openssl-1.0.0.patch"
}

src_compile() {
	distutils_src_compile

	if use doc; then
		cd doc
		einfo "Generation of documentation"
		PYTHONPATH="$(ls -d ../build-$(PYTHON -f --ABI)/lib.*)" epydoc --html --output=api --name=M2Crypto M2Crypto || die "Generation of documentation failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		pushd demo > /dev/null
		insinto /usr/share/doc/${PF}/example
		doins -r *
		popd > /dev/null
	fi
	dohtml -r doc/*
}
