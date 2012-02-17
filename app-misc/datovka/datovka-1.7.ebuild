# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/datovka/datovka-1.7.ebuild,v 1.2 2012/02/17 09:21:15 scarabeus Exp $

EAPI=4

PYTHON_DEPEND="2"

inherit distutils

DESCRIPTION="GUI to access Czech eGov \"Datove schranky\""
HOMEPAGE="http://labs.nic.cz/page/969/datovka/"
SRC_URI="http://labs.nic.cz/files/labs/datove_schranky/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	dev-python/pygtk:2
	dev-python/pyopenssl
	dev-python/reportlab
	dev-python/sqlalchemy
	media-fonts/dejavu
	>=net-libs/dslib-1.7
"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	python_convert_shebangs -r 4 "${WORKDIR}"
}

src_install() {
	distutils_src_install
	rm -rf "${ED}"/usr/share/${PN}/fonts/*
	dosym /usr/share/fonts/${PN}/DejaVuSans.ttf /usr/share/dsgui/fonts/DejaVuSans.ttf
}
