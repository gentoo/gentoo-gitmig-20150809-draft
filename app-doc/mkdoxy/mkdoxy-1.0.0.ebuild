# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/mkdoxy/mkdoxy-1.0.0.ebuild,v 1.3 2004/03/24 23:26:32 mholzer Exp $

DESCRIPTION="mkDoxy generates Doxygen-compatible HTML documentation for makefiles"
HOMEPAGE="http://sourceforge.net/projects/mkdoxy/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
RESTRICT="nomirror"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"

DEPEND="app-doc/doxygen
	>=dev-lang/perl-5"

src_install() {
	dobin mkdoxy
	dodoc AUTHORS COPYING ChangeLog INSTALL INSTALL.gentoo README \
	TODO VERSION
}
