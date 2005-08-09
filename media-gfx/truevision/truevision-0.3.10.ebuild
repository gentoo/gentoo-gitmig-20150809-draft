# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/truevision/truevision-0.3.10.ebuild,v 1.8 2005/08/09 20:58:40 vanquirius Exp $

inherit eutils

DESCRIPTION="Gnome frontend to Povray"
HOMEPAGE="http://truevision.sourceforge.net"
SRC_URI="mirror://sourceforge/truevision/${P}.tar.gz
	mirror://sourceforge/truevision/${PN}-extramat-${PV}.tar.gz
	mirror://gentoo/${P}-genpatch.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	gnome-base/gnome-libs
	media-gfx/povray
	sys-libs/zlib
	virtual/opengl
	<x11-libs/gtkglarea-1.99"

src_unpack() {
	unpack ${A}
	epatch ${WORKDIR}/truevision-0.3.10-gentoo{2,3,4}.patch
}

src_install() {
	einstall \
		PACKAGE_MATERIALS_DIR=${D}/usr/share/truevision/materials \
		PACKAGE_PIXMAPS_DIR=${D}/usr/share/pixmaps/truevision || die

	dodoc AUTHORS COPYING README ChangeLog INSTALL TODO
	cp -r ${S}/examples ${D}/usr/share/doc/${PF}/examples

	cd ${WORKDIR}/${PN}-extramat-${PV} || die
	cp -R materials ${D}/usr/share/truevision/materials/ || die
}
