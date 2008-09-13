# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/xwax/xwax-0.4.ebuild,v 1.1 2008/09/13 02:30:23 nixphoeni Exp $

inherit eutils

DESCRIPTION="Digital vinyl emulation software"
HOMEPAGE="http://www.xwax.co.uk/"
SRC_URI="http://www.xwax.co.uk/releases/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="alsa"

DEPEND="media-libs/libsdl
	media-libs/sdl-ttf
	media-fonts/ttf-bitstream-vera
	alsa? ( media-libs/alsa-lib )"

DOCS="README"

src_unpack() {
	unpack ${A}

	cd "${S}"
	# Fix fonts directory in source
	epatch "${FILESDIR}/${P}-fonts.patch"
	# Remove the 'CFLAGS += -Wall -03' line from Makefile
	# Add LDFLAGS to Makefile
	sed -i -e 's:^CFLAGS:#CFLAGS:' \
		-e 's:\($(CC) .* $(DEVICE_LIBS)\):\1 $(LDFLAGS):' \
		Makefile
}

src_compile() {
	econf $(use_enable alsa) || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	# Manually install into ${D}/usr/bin
	exeinto "/usr/bin"

	doexe xwax
	doexe xwax_import
	# Install documentation
	dodoc ${DOCS}
}
