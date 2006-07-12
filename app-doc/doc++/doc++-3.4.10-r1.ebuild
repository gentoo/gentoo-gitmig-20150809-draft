# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/doc++/doc++-3.4.10-r1.ebuild,v 1.1 2006/07/12 23:02:28 pvdabeel Exp $

inherit eutils

DESCRIPTION="Documentation system for C, C++, IDL and Java"
HOMEPAGE="http://docpp.sourceforge.net/"
SRC_URI="mirror://sourceforge/docpp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/flex.patch
}
		
src_compile() {
	econf || die
	emake all || die
}

src_install() {
	make install DESTDIR="${D}" || die
	dodoc CREDITS INSTALL NEWS PLATFORMS REPORTING-BUGS
}
