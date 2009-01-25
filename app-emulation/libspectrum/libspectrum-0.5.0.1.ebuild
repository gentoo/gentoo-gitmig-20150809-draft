# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/libspectrum/libspectrum-0.5.0.1.ebuild,v 1.1 2009/01/25 02:35:58 darkside Exp $

inherit eutils autotools

DESCRIPTION="Spectrum emulation library"
HOMEPAGE="http://fuse-emulator.sourceforge.net/libspectrum.php"
SRC_URI="mirror://sourceforge/fuse-emulator/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="audiofile bzip2 zlib"

RDEPEND="zlib? ( sys-libs/zlib )
	bzip2? ( >=app-arch/bzip2-1.0 )
	>=dev-libs/glib-2
	audiofile? ( >=media-libs/audiofile-0.2.3 )"
DEPEND="${RDEPEND}
	dev-lang/perl
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	#submitted upstream, see bug #0000000000000000000000000000000000000000000000
	epatch "${FILESDIR}/${P}-without-bzip2_zlib.patch"
	eautoreconf
}

src_compile() {
	econf --with-glib \
	$(use_with zlib zlib) \
	$(use_with bzip2 bzip2) \
	$(use_with audiofile libaudiofile) \
	|| die "econf failed!"
	emake || die "emake failed!"
}

src_install() {
	emake install DESTDIR="${D}" || die
	dodoc AUTHORS ChangeLog README THANKS doc/*.txt *.txt
	doman doc/libspectrum.3
}
