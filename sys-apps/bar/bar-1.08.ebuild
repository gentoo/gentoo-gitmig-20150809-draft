# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bar/bar-1.08.ebuild,v 1.1 2004/02/02 12:05:54 lanius Exp $

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
