# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gtksee/gtksee-0.5.4.ebuild,v 1.1 2003/09/22 07:31:07 msterret Exp $

DESCRIPTION="A simple but functional image viewer/browser - ACD See alike."
HOMEPAGE="http://gtksee.berlios.de/"
SRC_URI="http://download.berlios.de/gtksee/${P}.tar.gz"

IUSE="tiff png jpeg nls"
LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"

DEPEND="=x11-libs/gtk+-1.2*
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )
	png? ( >=media-libs/libpng-1.2.1 )"

src_compile() {
	econf `use_enable nls` || die
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc AUTHORS ChangeLog INSTALL NEWS README TODO
}
