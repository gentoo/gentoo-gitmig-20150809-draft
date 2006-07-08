# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/doc++/doc++-3.4.10.ebuild,v 1.14 2006/07/08 08:03:35 corsair Exp $

DESCRIPTION="Documentation system for C, C++, IDL and Java"
HOMEPAGE="http://docpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/docpp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc ppc64 ~sparc x86"
IUSE=""

RDEPEND="virtual/libc"

src_compile() {
	econf || die
	emake all || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc CREDITS INSTALL NEWS PLATFORMS REPORTING-BUGS
}
