# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/app-sci/ghemical/ghemical-0.90.ebuild,v 1.5 2003/02/13 09:21:36 vapier Exp $

DEPEND="gnome-base/gnome-libs
	dev-libs/libf2c
	x11-libs/gtkglext
	app-sci/mpqc"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DESCRIPTION="Ghemical supports both quantum-mechanics (semi-empirical and ab initio) models and molecular mechanics models (there is an experimental Tripos 5.2-like force field for organic molecules). Also a tool for reduced protein models is included. Geometry optimization, molecular dynamics and a large set of visualization tools are currently available."

HOMEPAGE="http://www.uku.fi/~thassine/ghemical/"
SRC_URI="http://www.uku.fi/~thassine/ghemical/download/${P}.tgz"

src_compile() {
	patch -p0 < ${FILESDIR}/${P}-gentoo.patch
	./configure --prefix=/usr --enable-mpqc
	emake
}

src_install() {
	sed -e "s:^prefix=.*:prefix=${D}/usr:" Makefile > Makefile.foo
	mv Makefile.foo Makefile
	make install
}
