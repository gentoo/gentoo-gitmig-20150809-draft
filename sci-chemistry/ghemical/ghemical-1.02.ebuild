# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-chemistry/ghemical/ghemical-1.02.ebuild,v 1.1 2005/07/09 00:08:06 spyderous Exp $

inherit eutils

DESCRIPTION="Ghemical supports both quantum-mechanics (semi-empirical and ab initio) models and molecular mechanics models (there is an experimental Tripos 5.2-like force field for organic molecules). Also a tool for reduced protein models is included. Geometry optimization, molecular dynamics and a large set of visualization tools are currently available."
HOMEPAGE="http://www.uku.fi/~thassine/ghemical/"
SRC_URI="http://www.uku.fi/~thassine/ghemical/download/${P}.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mpqc gtk"

DEPEND="dev-libs/libf2c
	sci-chemistry/mopac7
	>=sci-chemistry/openbabel-1.100.2
	sci-chemistry/mpqc
	>=media-libs/glut-3.7
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
		$(use_enable gtk) ||die
	emake || die "Configure failed"
}

src_install() {
	sed -e "s:^prefix=.*:prefix=${D}/usr:" -i Makefile
	make install || die "Install failed"
}
