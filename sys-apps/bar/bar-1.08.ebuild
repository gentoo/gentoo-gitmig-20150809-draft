# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/bar/bar-1.08.ebuild,v 1.5 2005/01/09 20:23:22 ka0ttic Exp $

DESCRIPTION="Console Progress Bar"
HOMEPAGE="http://clpbar.sourceforge.net/"
KEYWORDS="x86"
IUSE=""
SLOT="0"
LICENSE="GPL-2"
SRC_URI="mirror://sourceforge/clpbar/${P}.tar.gz"
DEPEND=">=sys-apps/sed-4"

src_unpack() {
	unpack ${A}
	sed -i -e "s:CFLAGS = :CFLAGS=${CFLAGS}:" ${S}/Makefile.in
}

src_install() {
	einstall
}
