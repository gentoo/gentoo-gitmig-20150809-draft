# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xwax/xwax-0.4.ebuild,v 1.6 2009/06/07 04:46:12 ssuominen Exp $

EAPI=2
inherit eutils toolchain-funcs

DESCRIPTION="Digital vinyl emulation software"
HOMEPAGE="http://www.xwax.co.uk/"
SRC_URI="http://www.xwax.co.uk/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="alsa"

RDEPEND="media-libs/libsdl
	media-libs/sdl-ttf
	media-fonts/ttf-bitstream-vera
	alsa? ( media-libs/alsa-lib )"
DEPEND="${RDEPEND}"

src_prepare() {
	# Fix fonts directory in source
	epatch "${FILESDIR}/${P}-fonts.patch"
	# Remove the 'CFLAGS += -Wall -03' line from Makefile
	# Add LDFLAGS to Makefile
	sed -i -e 's:^CFLAGS:#CFLAGS:' \
		-e 's:\($(CC) .* $(DEVICE_LIBS)\):\1 $(LDFLAGS):' \
		Makefile || die "sed failed"
}

src_configure() {
	tc-export CC
	econf \
		$(use_enable alsa)
}

src_install() {
	dobin xwax xwax_import || die
	dodoc README || die
}
