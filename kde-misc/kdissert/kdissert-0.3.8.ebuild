# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kdissert/kdissert-0.3.8.ebuild,v 1.1 2005/03/28 20:57:17 carlo Exp $

inherit kde

MY_P=${P/_/.}
S=${WORKDIR}/${MY_P}

DESCRIPTION="KDissert - a mindmapping-like tool"
HOMEPAGE="http://www.freehackers.org/~tnagy/kdissert/index.html"
#SRC_URI="http://www.freehackers.org/~tnagy/kdissert/${MY_P}.tar.bz2"
SRC_URI="http://www.kde-apps.org/content/files/12725-${MY_P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

DEPEND=">=dev-util/scons-0.96.1
	>=dev-lang/python-2.3"
need-kde 3.2

src_compile() {
	scons configure prefix="${D}/usr" kdeinclude="$(kde-config --prefix)/include"  || configure failed
	scons ${MAKEOPTS}
}

src_install() {
	scons install
}
