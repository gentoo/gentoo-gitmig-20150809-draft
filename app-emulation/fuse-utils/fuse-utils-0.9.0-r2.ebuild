# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/fuse-utils/fuse-utils-0.9.0-r2.ebuild,v 1.3 2008/10/05 16:44:01 flameeyes Exp $

inherit eutils autotools

DESCRIPTION="Utils for the Free Unix Spectrum Emulator by Philip Kendall"
HOMEPAGE="http://fuse-emulator.sourceforge.net"
SRC_URI="mirror://sourceforge/fuse-emulator/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="audiofile"

RDEPEND=">=app-emulation/libspectrum-0.4.0
	audiofile? ( >=media-libs/audiofile-0.2.3 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	#submitted upstream, see bug #224321
	epatch "${FILESDIR}/${P}-without-audiofile.patch"
	eautoreconf
}

src_compile() {
	econf $(use_with audiofile ) || die "Configure failed!"
	emake || die "Make failed!"
}

src_install() {
		emake install DESTDIR="${D}" || die "install failed"
		dodoc AUTHORS ChangeLog README
		doman man/*.1
}
