# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2

DESCRIPTION="mkDoxy generates Doxygen-compatible HTML documentation for makefiles"
HOMEPAGE="http://sourceforge.net/projects/mkdoxy/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc ~sparc ~mips ~alpha ~arm ~hppa ~amd64 ~ia64"

RDEPEND="app-doc/doxygen
	>=dev-lang/perl-5"

DEPEND="${RDEPEND}"

src_install() {
	dobin mkdoxy
	dodoc AUTHORS COPYING ChangeLog INSTALL INSTALL.gentoo README \
	TODO VERSION
}
