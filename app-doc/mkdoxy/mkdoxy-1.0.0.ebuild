# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/mkdoxy/mkdoxy-1.0.0.ebuild,v 1.2 2004/02/17 08:32:43 mr_bones_ Exp $

DESCRIPTION="mkDoxy generates Doxygen-compatible HTML documentation for makefiles"
HOMEPAGE="http://sourceforge.net/projects/mkdoxy/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64 ~ia64"

RDEPEND="app-doc/doxygen
	>=dev-lang/perl-5"

DEPEND="${RDEPEND}"

src_install() {
	dobin mkdoxy
	dodoc AUTHORS COPYING ChangeLog INSTALL INSTALL.gentoo README \
	TODO VERSION
}
