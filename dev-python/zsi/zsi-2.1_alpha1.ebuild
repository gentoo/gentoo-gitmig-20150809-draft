# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/zsi/zsi-2.1_alpha1.ebuild,v 1.5 2011/05/18 19:52:29 angelos Exp $

EAPI="3"
PYTHON_DEPEND="2:2.4"

inherit distutils

MY_PN="ZSI"
MY_P="${MY_PN}-${PV/_alpha/-a}"

DESCRIPTION="Web Services for Python"
HOMEPAGE="http://pywebsvcs.sourceforge.net/zsi.html"
SRC_URI="mirror://sourceforge/pywebsvcs/${MY_P}.tar.gz"

KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
SLOT="0"
LICENSE="PYTHON"
IUSE="examples doc twisted"

DEPEND=">=dev-python/setuptools-0.6_rc7-r1
	twisted? ( >=dev-python/twisted-2
		>=dev-python/twisted-web-0.5 )"

S="${WORKDIR}/${MY_P}"
PYTHON_MODNAME="${MY_PN}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	if ! use twisted; then
		sed -i \
			-e "/version_info/d"\
			-e "/ZSI.twisted/d"\
			setup.py || die "sed failed"
	fi
}

src_install() {
	distutils_src_install

	if use doc; then
		dohtml doc/*.{html,css,png}
	fi

	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins -r doc/examples/* samples/*
	fi
}

DOCS="CHANGES README"
