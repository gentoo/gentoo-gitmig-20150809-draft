# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/truevision/truevision-0.3.10.ebuild,v 1.1 2003/03/16 22:09:16 malverian Exp $

DESCRIPTION="Gnome frontend to Povray"
HOMEPAGE="http://truevision.sourceforge.net"
SRC_URI="http://unc.dl.sourceforge.net/sourceforge/truevision/${P}.tar.gz http://unc.dl.sourceforge.net/sourceforge/truevision/${PN}-extramat-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

DEPEND="=x11-libs/gtk+-1.2*
	media-gfx/povray"

RDEPEND=${DEPEND}

S="${WORKDIR}/${P}"

src_compile() {
	epatch ${FILESDIR}/truevision-0.3.10-gentoo1.patch || die
	econf --prefix=${D}/usr --datadir=${D}/usr/share || die
	emake || die
}

src_install() {
	emake PREFIX=${D}/usr DATADIR=${D}/usr/share PACKAGE_MATERIALS_DIR=${D}/usr/share/truevision/materials PACKAGE_PIXMAPS_DIR=${D}/usr/share/pixmaps/truevision install || die

	cd ${WORKDIR}/${PN}-extramat-${PV} || die
	cp -R materials ${D}/usr/share/truevision/materials/ || die
}
