# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gimp-freetype/gimp-freetype-0.6.ebuild,v 1.5 2006/03/10 19:30:02 corsair Exp $

DESCRIPTION="Freetype text plugin for The Gimp 2"
SRC_URI="mirror://gimp/plug-ins/v2.0/freetype/${P}.tar.gz"
HOMEPAGE="http://freetype.gimp.org/"

SLOT="2"
LICENSE="GPL-2"
KEYWORDS="amd64 ppc ~ppc64 x86"
IUSE=""

RDEPEND=">=media-gfx/gimp-2
	>=media-libs/freetype-2"

DEPEND="${RDEPEND}
	dev-util/intltool
	dev-util/pkgconfig"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc AUTHORS ChangeLog HACKING NEWS README TODO
}
