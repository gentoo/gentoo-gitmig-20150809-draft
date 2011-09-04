# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/soappy/soappy-0.12.5.ebuild,v 1.2 2011/09/04 07:01:44 djc Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit eutils distutils

MY_PN="SOAPpy"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="SOAP implementation for Python"
HOMEPAGE="http://pywebsvcs.sourceforge.net/"
SRC_URI="mirror://pypi/${MY_PN:0:1}/${MY_PN}/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="BSD"
IUSE="examples ssl"

DEPEND=">=dev-python/fpconst-0.7.1
		dev-python/pyxml
		dev-python/wstools"
RDEPEND="${DEPEND}
		ssl? ( dev-python/m2crypto )"

S="${WORKDIR}/${MY_P}"

DOCS="CHANGES.txt README.txt docs/*"
PYTHON_MODNAME="${MY_PN}"

pkg_setup() {
	python_pkg_setup
	if use ssl && ! has_version "=dev-lang/python-2*[ssl]"; then
		ewarn "The 'ssl' USE-flag is enabled, but dev-lang/python is"
		ewarn "not compiled with it. You'll only get server-side SSL support."
		ewarn "Just emerge dev-lang/python afterwards with the ssl USE-flag to"
		ewarn "get client-side encryption."
	fi
}

src_prepare() {
	distutils_src_prepare
	find -name .cvsignore -print0 | xargs -0 rm -f
}

src_install() {
	distutils_src_install
	dodoc docs/*
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r bid contrib tools validate
	fi
}
