# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/ghemical/ghemical-1.02.ebuild,v 1.6 2006/06/17 01:02:47 spyderous Exp $

inherit eutils

DESCRIPTION="Chemical quantum mechanics and molecular mechanics"
HOMEPAGE="http://bioinformatics.org/ghemical/"
SRC_URI="http://www.uku.fi/~thassine/ghemical/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mpqc gtk"

DEPEND="dev-libs/libf2c
	sci-chemistry/mopac7
	=sci-chemistry/openbabel-1.1*
	sci-chemistry/mpqc
	virtual/glut
	dev-libs/libxml
	>=dev-util/pkgconfig-0.15
	=x11-libs/gtkglarea-1.2*
	=gnome-base/libglade-0*
	gtk? (
		gnome-base/gnome-libs
	)"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/gcc3.4-r1.patch
}

src_compile() {
	./configure \
		--prefix=/usr \
		$(use_enable mpqc) \
		$(use_enable gtk) || die "Configure failed"
	emake || die "Make failed"
}

src_install() {
	sed -e "s:^prefix=.*:prefix=${D}/usr:" -i Makefile
	make install || die "Install failed"
}
