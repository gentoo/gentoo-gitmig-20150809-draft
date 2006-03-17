# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/uade/uade-2.02.ebuild,v 1.1 2006/03/17 15:07:12 spock Exp $

inherit eutils

DESCRIPTION="Unix Amiga Delitracker Emulator - plays old Amiga tunes through UAE emulation and cloned m68k-assembler Eagleplayer API"
HOMEPAGE="http://zakalwe.fi/uade"
SRC_URI="http://zakalwe.fi/uade/uade2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="xmms audacious"

RDEPEND="media-libs/libao
	xmms? ( >=media-sound/xmms-1.2.2 )
	audacious? ( >=media-sound/audacious-0.2 )"

DEPEND="${RDEPEND}"

src_compile() {
	./configure \
		--prefix=/usr \
		--package-prefix="${D}" \
		$(use_with xmms) \
		$(use_with audacious) \
		|| die "configure failed"
	emake || die 'emake failed'
}

src_install() {
	make install || die 'make install failed'
	dodoc AUTHORS ChangeLog doc/BUGS doc/PLANS
	doman doc/uade123.1
}
