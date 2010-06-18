# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/pymemphis/pymemphis-0.2.1.ebuild,v 1.2 2010/06/18 21:36:17 jlec Exp $

EAPI="3"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
PYTHON_EXPORT_PHASE_FUNCTIONS="1"
AT_M4DIR="build/autotools/"

inherit autotools python

DESCRIPTION="Python bindings for the libmemphis library"
HOMEPAGE="http://gitorious.net/pymemphis"
SRC_URI="mirror://gentoo/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~x86"
LICENSE="LGPL-2.1"
IUSE=""

RDEPEND="
	dev-python/pycairo
	dev-python/pygobject
	media-libs/memphis"
DEPEND="${RDEPEND}"

RESTRICT_PYTHON_ABIS="3.*"

S="${WORKDIR}"/${PN}-mainline

src_prepare() {
	eautoreconf
	echo "#!${EPREFIX}/bin/sh" > py-compile
	sed 's:0.1:0.2:g' -i pymemphis.pc.in || die
	python_src_prepare
}

src_install() {
	python_src_install
	python_clean_installation_image
	dodoc AUTHORS ChangeLog README || die
}
