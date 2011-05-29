# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/prewikka/prewikka-0.9.14-r2.ebuild,v 1.7 2011/05/29 16:20:14 armin76 Exp $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils

DESCRIPTION="Prelude-IDS Frontend"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86"
IUSE=""

DEPEND=">=dev-python/cheetah-0.9.18
	>=dev-libs/libprelude-0.9.0[python]
	>=dev-libs/libpreludedb-0.9.0[python]"
RDEPEND="${DEPEND}"

DISTUTILS_USE_SEPARATE_SOURCE_DIRECTORIES="1"

src_install() {
	distutils_src_install
	mv "${D}"/etc/prewikka/prewikka.conf \
		"${D}"/etc/prewikka/prewikka.conf-sample
	fperms 640 /etc/prewikka/prewikka.conf-sample
}

pkg_postinst() {
	distutils_pkg_postinst

	elog
	elog "For additional installation instructions go to"
	elog "https://trac.prelude-ids.org/wiki/InstallingPrewikka"
	elog
	elog "The default config from the website is installed as"
	elog "/etc/prewikka/prewikka.conf-sample"
	elog "Remember to chgrp the conf file so it is readable by your"
	elog "http server's group"
}
