# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libspectrum/libspectrum-0.1.1.ebuild,v 1.1 2003/07/16 00:24:17 vapier Exp $

DESCRIPTION="Spectrum emulation library"
HOMEPAGE="http://www.srcf.ucam.org/~pak21/spectrum/libspectrum.html"
SRC_URI="http://www.srcf.ucam.org/~pak21/spectrum/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="gnome"

DEPEND="gnome? ( =dev-libs/glib-1* )"

src_compile() {
	econf `use_with gnome glib` || die
	make || die "libspectrum make failed!"
}

src_install() {
	make install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog README THANKS doc/*.txt
}
