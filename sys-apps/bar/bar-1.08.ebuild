# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bar/bar-1.08.ebuild,v 1.2 2004/06/24 21:58:59 agriffis Exp $

DESCRIPTION="Console Progress Bar"
HOMEPAGE="http://clpbar.sourceforge.net/"
KEYWORDS="~x86"
SLOT="0"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/clpbar/${P}.tar.gz"

src_unpack() {
	unpack ${A}
	sed -i -e "s:CFLAGS = :CFLAGS=${CFLAGS}:" ${S}/Makefile.in
}

src_install() {
	einstall
}
