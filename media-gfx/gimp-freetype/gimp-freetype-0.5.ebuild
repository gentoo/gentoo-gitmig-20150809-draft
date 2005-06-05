# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-freetype/gimp-freetype-0.5.ebuild,v 1.8 2005/06/05 12:10:51 hansmi Exp $

IUSE=""

DESCRIPTION="Freetype text plugin for The Gimp 2"
SRC_URI="mirror://gimp/plug-ins/v2.0/freetype/${P}.tar.gz"
HOMEPAGE="http://freetype.gimp.org/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc x86"

RDEPEND=">=media-gfx/gimp-2
	>=media-libs/freetype-2"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	dev-util/pkgconfig"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	local GIMP_LIBDIR=$(pkg-config --variable=gimplibdir gimp-2.0)

	einstall bindir=${D}/${GIMP_LIBDIR}/plug-ins || die

	dodoc AUTHORS ChangeLog COPYING HACKING NEWS README TODO
}
