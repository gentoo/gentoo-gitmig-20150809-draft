# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdissert/kdissert-0.3.0.ebuild,v 1.1 2004/11/25 17:27:11 carlo Exp $

inherit kde

DESCRIPTION="KDissert - a mindmapping-like tool"
HOMEPAGE="http://freehackers.org/~tnagy/kdissert/index.html"
SRC_URI="http://freehackers.org/~tnagy/kdissert/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

need-kde 3.2

# rotten Makefile stuff, can't use kde.eclass
src_compile() {
	./configure --prefix=${D}/usr || configure failed
	emake || emake failed
}

src_install() {
	einstall || einstall failed
}