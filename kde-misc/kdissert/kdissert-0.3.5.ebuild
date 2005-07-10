# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdissert/kdissert-0.3.5.ebuild,v 1.3 2005/07/10 21:17:11 swegener Exp $

inherit kde

DESCRIPTION="KDissert - a mindmapping-like tool"
HOMEPAGE="http://www.freehackers.org/~tnagy/kdissert/index.html"
SRC_URI="http://www.freehackers.org/~tnagy/kdissert/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
IUSE=""

DEPEND="dev-util/scons"
need-kde 3.2

# rotten Makefile stuff, can't use kde.eclass
src_compile() {
	./configure --prefix=${D}/usr || configure failed
	emake || die "emake failed"
}

src_install() {
	einstall || einstall failed
}
