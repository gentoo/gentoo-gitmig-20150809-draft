# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/truevision/truevision-0.3.10.ebuild,v 1.2 2003/06/10 22:09:30 liquidx Exp $

DESCRIPTION="Gnome frontend to Povray"
HOMEPAGE="http://truevision.sourceforge.net"
SRC_URI="mirror://sourceforge/truevision/${P}.tar.gz 
	mirror://sourceforge/truevision/${PN}-extramat-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	media-gfx/povray
	sys-libs/zlib
	virtual/opengl
	<x11-libs/gtkglarea-1.99"

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/truevision-0.3.10-gentoo2.patch || die
	epatch ${FILESDIR}/truevision-0.3.10-gentoo3.patch || die 
}

src_compile() {
	econf || die
	emake || die
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
