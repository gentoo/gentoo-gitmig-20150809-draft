# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/prewikka/prewikka-0.9.3.ebuild,v 1.4 2006/04/08 16:59:03 dertobi123 Exp $

inherit versionator distutils

DESCRIPTION="Prelude-IDS Frontend"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="ppc sparc x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	>=dev-python/cheetah-0.9.18"

RDEPEND="${DEPEND}
	>=dev-libs/libprelude-0.9.0
	>=dev-libs/libpreludedb-0.9.0"

pkg_setup() {
	if ! built_with_use dev-libs/libprelude python ;
	then
		die 'requires dev-libs/libprelude to be built with "python" use flag'
	fi

}

src_install() {
	distutils_src_install
	rm "${D}"/\-dist
}

pkg_postinst() {
	einfo "For additional installation instructions go to"
	einfo "https://trac.prelude-ids.org/wiki/InstallingPrewikka"
}
