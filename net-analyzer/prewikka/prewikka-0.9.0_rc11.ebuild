# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/prewikka/prewikka-0.9.0_rc11.ebuild,v 1.1 2005/08/26 21:54:45 vanquirius Exp $

inherit versionator distutils

MY_P="${PN}-$(replace_version_separator 3 '-')"
DESCRIPTION="Prelude-IDS Frontend"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	dev-python/cheetah"

RDEPEND="${DEPEND}
	>=dev-libs/libprelude-0.9.0_rc5
	>=dev-libs/libpreludedb-0.9.0_rc5"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	if ! built_with_use dev-libs/libprelude python || \
		! built_with_use dev-libs/libprelude python;
	then
		die 'requires dev-libs/libprelude and dev-libs/libprelude to be build with "python" use flag'
	fi

}

src_install() {
	distutils_src_install
	rm ${D}/\-dist
}

pkg_postinst() {
	einfo "For additional installation instructions go to"
	einfo "https://trac.prelude-ids.org/wiki/InstallingPrewikka"
}
