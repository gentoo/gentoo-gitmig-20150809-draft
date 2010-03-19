# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/uade/uade-2.13.ebuild,v 1.5 2010/03/19 14:08:46 spock Exp $

inherit eutils

DESCRIPTION="Unix Amiga Delitracker Emulator - plays old Amiga tunes through UAE emulation"
HOMEPAGE="http://zakalwe.fi/uade"
SRC_URI="http://zakalwe.fi/uade/uade2/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc x86"
IUSE=""

RDEPEND="media-libs/libao"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_compile() {
	./configure \
		--prefix=/usr \
		--package-prefix="${D}" \
		--with-uade123 \
		--with-text-scope \
		--without-xmms \
		--without-audacious \
		|| die "configure failed"
	emake || die 'emake failed'
}

src_install() {
	make install || die 'make install failed'
	dodoc AUTHORS ChangeLog doc/BUGS doc/PLANS
	doman doc/uade123.1
}
