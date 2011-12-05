# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/dslib/dslib-1.7.ebuild,v 1.1 2011/12/05 13:57:02 scarabeus Exp $

EAPI=4

PYTHON_DEPEND="*"

inherit distutils

DESCRIPTION="Library to access Czech eGov system \"Datove schranky\""
HOMEPAGE="http://labs.nic.cz/page/969/datovka/"
SRC_URI="http://labs.nic.cz/files/labs/datove_schranky/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/pyasn1
	dev-python/pyopenssl
	dev-python/suds
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
	rm -rf "${ED}"/usr/share/${PN}/{{LICENSE,README}.txt,pyasn1}
}
