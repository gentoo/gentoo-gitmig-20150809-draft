# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libspectrum/libspectrum-0.2.0.1-r1.ebuild,v 1.2 2003/11/24 22:39:45 vapier Exp $

DESCRIPTION="Spectrum emulation library"
HOMEPAGE="http://www.srcf.ucam.org/~pak21/spectrum/libspectrum.html"
SRC_URI="mirror://sourceforge/fuse-emulator/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="=dev-libs/glib-1*
	dev-libs/libgcrypt
	dev-lang/perl"

src_compile() {
	econf --with-glib || die
	emake -j1 || die "libspectrum make failed!"
}

src_install() {
	emake install DESTDIR=${D} || die
	dodoc AUTHORS ChangeLog README THANKS doc/*.txt *.txt
}
