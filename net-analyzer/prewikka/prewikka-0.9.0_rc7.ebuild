# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/prewikka/prewikka-0.9.0_rc7.ebuild,v 1.1 2005/07/01 16:05:01 ka0ttic Exp $

inherit versionator distutils

MY_P="${PN}-$(replace_version_separator 3 '-')"
DESCRIPTION="Prelude-IDS Frontend"
HOMEPAGE="http://www.prelude-ids.org/"
SRC_URI="http://www.prelude-ids.org/download/releases/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND=">=dev-lang/python-2.3
	dev-python/cheetah"

S="${WORKDIR}/${MY_P}"

src_install() {
	distutils_src_install
	rm ${D}/\-dist
}

pkg_postinst() {
	einfo "For additional installation instructions go to"
	einfo "https://trac.prelude-ids.org/wiki/InstallingPrewikka"
}
