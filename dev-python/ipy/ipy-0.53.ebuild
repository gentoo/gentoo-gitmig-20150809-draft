# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ipy/ipy-0.53.ebuild,v 1.2 2007/07/11 06:19:47 mr_bones_ Exp $

inherit eutils distutils

MY_P="${P/ip/IP}"

DESCRIPTION="A python Module for handling IP-Addresses and Networks"
SRC_URI="http://cheeseshop.python.org/packages/source/I/IPy/${MY_P}.tar.gz"
HOMEPAGE="http://software.inl.fr/trac/trac.cgi/wiki/IPy"
SLOT="0"
LICENSE="BSD"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE="examples"

S="${WORKDIR}/${MY_P}"

src_test() {
	"${python}" test/test_IPy.py || die "src_test failed"
}

src_install() {
	DOCS="AUTHORS"
	distutils_src_install

	if use examples; then
		insinto /usr/share/doc/${PF}
		doins -r example
	fi
}
