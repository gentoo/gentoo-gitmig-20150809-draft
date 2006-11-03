# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipy/ipy-0.51.ebuild,v 1.1 2006/11/03 20:10:03 lucass Exp $

inherit eutils distutils

MY_P="${P/ip/IP}"
DESCRIPTION="A python Module for handling IP-Addresses and Networks"
SRC_URI="http://cheeseshop.python.org/packages/source/I/IPy/${MY_P}.tar.gz"
HOMEPAGE="http://software.inl.fr/trac/trac.cgi/wiki/IPy"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"

DEPEND="virtual/python"
IUSE=""
S="${WORKDIR}/${MY_P}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/${P}-nosetuptools.diff"
}

src_test() {
	"${python}" test/test_IPy.py || die "src_test failed"
}

src_install() {
	distutils_src_install

	dodoc AUTHORS
	cp -r example "${D}/usr/share/doc/${PF}/"
}
