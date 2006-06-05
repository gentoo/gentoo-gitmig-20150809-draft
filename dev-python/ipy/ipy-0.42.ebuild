# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipy/ipy-0.42.ebuild,v 1.1 2006/06/05 05:38:38 lucass Exp $

inherit distutils

MY_P="${P/ip/IP}"
DESCRIPTION="A python Module for handling IP-Addresses and Networks"
SRC_URI="http://c0re.23.nu/c0de/IPy/${MY_P}.tar.gz"
HOMEPAGE="http://c0re.23.nu/c0de/IPy/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64"

DEPEND="virtual/python"
IUSE=""
S="${WORKDIR}/${MY_P}"


src_test() {
	${python} test/test_IPy.py || die "src_test failed"
}

src_install() {
	distutils_src_install

	dodoc CHANGES THANKS
	cp -r example "${D}/usr/share/doc/${PF}/"
}
