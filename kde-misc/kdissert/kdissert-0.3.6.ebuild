# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdissert/kdissert-0.3.6.ebuild,v 1.1 2005/02/28 23:09:30 carlo Exp $

inherit kde

MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

DESCRIPTION="KDissert - a mindmapping-like tool"
HOMEPAGE="http://www.freehackers.org/~tnagy/kdissert/index.html"
#SRC_URI="http://www.freehackers.org/~tnagy/kdissert/${MY_P}.tar.bz2"
SRC_URI="http://www.kde-apps.org/content/files/12725-${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc"
IUSE=""

DEPEND="dev-util/scons"
need-kde 3.2

# rotten Makefile stuff, can't use kde.eclass
src_compile() {
	./configure --prefix="${D}/usr" --kdeincludes="$(kde-config --prefix)/include"  || configure failed
	emake || emake failed
}

src_install() {
	einstall || einstall failed
}
