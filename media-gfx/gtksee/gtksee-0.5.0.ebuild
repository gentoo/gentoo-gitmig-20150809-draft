# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gtksee/gtksee-0.5.0.ebuild,v 1.9 2003/02/13 12:35:24 vapier Exp $

IUSE="tiff png jpeg"

S=${WORKDIR}/${P}
DESCRIPTION="A simple but functional image viewer/browser - ACD See alike."
HOMEPAGE="http://www.unmaintained-free-software.org/showproject.php?id=181"
SRC_URI="http://village.flashnet.it/users/fn048069/files/srctars/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND="=x11-libs/gtk+-1.2*
	jpeg? ( media-libs/jpeg )
	tiff? ( media-libs/tiff )
	png? ( >=media-libs/libpng-1.2.1 )"

src_compile() {
	econf || die
	emake || die
}

src_install() {
	einstall || die
	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING INSTALL NEWS README TODO
}
