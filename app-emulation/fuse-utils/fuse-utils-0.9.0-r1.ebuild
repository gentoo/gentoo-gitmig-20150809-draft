# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/fuse-utils/fuse-utils-0.9.0-r1.ebuild,v 1.1 2008/06/02 02:56:41 darkside Exp $

DESCRIPTION="Utils for the Free Unix Spectrum Emulator by Philip Kendall"
HOMEPAGE="http://fuse-emulator.sourceforge.net"
SRC_URI="mirror://sourceforge/fuse-emulator/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="audiofile"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"
RDEPEND=">=app-emulation/libspectrum-0.4.0
	audiofile? ( >=media-libs/audiofile-0.2.3 )"

src_install() {
		emake install DESTDIR="${D}" || die "install failed"
		dodoc AUTHORS ChangeLog README
		doman man/*.1
}
