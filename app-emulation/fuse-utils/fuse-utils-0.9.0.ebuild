# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/fuse-utils/fuse-utils-0.9.0.ebuild,v 1.1 2008/05/30 01:56:01 darkside Exp $

DESCRIPTION="Utils for the Free Unix Spectrum Emulator by Philip Kendall"
HOMEPAGE="http://fuse-emulator.sourceforge.net"
SRC_URI="mirror://sourceforge/fuse-emulator/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=app-emulation/libspectrum-0.4.0"

src_compile() {
	econf || die "econf failed!"
	emake || die "emake failed!"
}

src_install() {
		emake install DESTDIR="${D}" || die
		dodoc AUTHORS ChangeLog README THANKS
		doman man/fuse.1
}
