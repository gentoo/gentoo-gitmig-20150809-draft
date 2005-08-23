# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/dvacm4/dvacm4-0.3.5-r1.ebuild,v 1.5 2005/08/23 16:01:24 agriffis Exp $

inherit eutils

DESCRIPTION="dvacm4 provides autoconf macros used by the dv* C++ utilities"
HOMEPAGE="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvacm4/"
SRC_URI="http://tinf2.vub.ac.be/~dvermeir/software/dv/dvacm4/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/${P}-fix-underquoted-m4.diff
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog README NEWS
}
