# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/PyMca/PyMca-4.4.1_p1.ebuild,v 1.1 2010/12/07 07:52:29 jlec Exp $

EAPI=3

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils eutils

MY_PV="${PV/_}"

DESCRIPTION="X-ray Fluorescence Toolkit"
HOMEPAGE="http://pymca.sourceforge.net/"
SRC_URI="mirror://sourceforge/project/pymca/pymca/${PN}${PV/_p1}/pymca${MY_PV}-src.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="X matplotlib"

DEPEND="
	dev-python/numpy
	dev-python/sip
	virtual/opengl
	X? (
	     dev-python/PyQt4
	     dev-python/pyqwt
	   )
	matplotlib? ( dev-python/matplotlib )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}${MY_PV}"

src_prepare() {
	epatch "${FILESDIR}"/${PV}-gentoo.patch
	export SPECFILE_USE_GNU_SOURCE=1
	distutils_src_prepare
}
