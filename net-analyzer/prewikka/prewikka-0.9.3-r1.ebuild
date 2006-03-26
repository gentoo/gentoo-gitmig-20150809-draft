# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/prewikka/prewikka-0.9.3-r1.ebuild,v 1.1 2006/03/26 23:56:20 jokey Exp $

inherit distutils

DESCRIPTION="Prelude-IDS Frontend"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~sparc ~x86"
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
	dodir /etc/prewikka
	insinto /etc/prewikka
	doins ${FILESDIR}/prewikka.conf-sample
	rm "${D}"/\-dist
}

pkg_postinst() {
	einfo
	einfo "For additional installation instructions go to"
	einfo "https://trac.prelude-ids.org/wiki/InstallingPrewikka"
	einfo
	einfo "The default config from the website is installed as"
	einfo "/etc/prewikka/prewikka.conf-sample"
}
