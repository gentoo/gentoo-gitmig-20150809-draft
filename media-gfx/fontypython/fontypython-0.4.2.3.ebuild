# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/fontypython/fontypython-0.4.2.3.ebuild,v 1.1 2009/10/26 05:25:32 dirtyepic Exp $

EAPI=2

inherit distutils multilib python

DESCRIPTION="Font preview application"
HOMEPAGE="http://savannah.nongnu.org/projects/fontypython"
SRC_URI="http://download.savannah.nongnu.org/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-lang/python:2.6
	dev-python/imaging
	dev-python/wxpython:2.8
	x11-libs/wxGTK:2.8[-debug]"
RDEPEND="${DEPEND}"

src_install() {
	python_version
	distutils_src_install \
		--install-data=/usr/$(get_libdir)/python${PYVER}/site-packages
	doman "${S}"/fontypython.1
}

pkg_postinst() {
	pydir=/usr/$(get_libdir)/python${PYVER}/site-packages/fontypythonmodules
	python_mod_optimize ${pydir}
}

pkg_postrm() {
	pydir=/usr/$(get_libdir)/python${PYVER}/site-packages/fontypythonmodules
	python_mod_cleanup ${pydir}
}
