# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/editra/editra-0.5.32.ebuild,v 1.2 2010/02/19 00:21:13 dirtyepic Exp $

EAPI=2

inherit distutils eutils fdo-mime

MY_PN=${PN/e/E}

DESCRIPTION="Multi-platform text editor supporting over 50 programming languages."
HOMEPAGE="http://editra.org http://pypi.python.org/pypi/Editra"
SRC_URI="http://editra.org/uploads/src/${MY_PN}-${PV}.tar.gz"

LICENSE="wxWinLL-3.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="spell"

DEPEND=">=dev-lang/python-2.5
		>=dev-python/wxpython-2.8.9.2:2.8
		dev-python/setuptools"
# setuptools is RDEPEND because it's used by the runtime for installing plugins
RDEPEND="${DEPEND}
	spell? ( dev-python/pyenchant )"

S="${WORKDIR}"/${MY_PN}-${PV}

src_prepare() {
	#http://code.google.com/p/editra/issues/detail?id=481
	epatch "${FILESDIR}"/${P}-sandbox.patch
	# next version, use setup.py install --no-clean
}

src_install() {
	distutils_src_install
	insinto /usr/share/pixmaps
	doins "${S}"/pixmaps/editra.png
	make_desktop_entry Editra Editra editra "Development;TextEditor"
	dodoc FAQ THANKS
}

pkg_postinst() {
	distutils_pkg_postinst
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	distutils_pkg_postrm
	fdo-mime_desktop_database_update
}
