# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdissert/kdissert-0.3.4.1.ebuild,v 1.2 2005/01/26 10:36:43 greg_g Exp $

inherit kde eutils

DESCRIPTION="KDissert - a mindmapping-like tool"
HOMEPAGE="http://www.freehackers.org/~tnagy/kdissert/index.html"
SRC_URI="http://www.freehackers.org/~tnagy/kdissert/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"
IUSE=""

DEPEND="dev-util/scons"
need-kde 3.2

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/${PN}-0.3.2-SConstruct.diff
}

# rotten Makefile stuff, can't use kde.eclass
src_compile() {
	./configure --prefix=${D}/usr || configure failed
	emake || emake failed
}

src_install() {
	einstall || einstall failed
}
