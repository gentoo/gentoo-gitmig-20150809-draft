# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/ghemical/ghemical-1.01.ebuild,v 1.3 2006/06/17 01:02:47 spyderous Exp $

inherit eutils

DESCRIPTION="Chemical quantum mechanics and molecular mechanics"
HOMEPAGE="http://bioinformatics.org/ghemical/"
SRC_URI="http://www.uku.fi/~thassine/ghemical/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="gnome-base/gnome-libs
	dev-libs/libf2c
	sci-chemistry/mpqc
	=x11-libs/gtkglarea-1.2*
	>=media-libs/glut-3.7
	dev-libs/libxml
	=gnome-base/libglade-0*"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gcc3.4-r1.patch
}

src_compile() {
	./configure --prefix=/usr --enable-mpqc ||die
	emake ||die
}

src_install() {
	sed -e "s:^prefix=.*:prefix=${D}/usr:" -i Makefile
	make install||die
}
