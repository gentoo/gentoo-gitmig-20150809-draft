# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wv2/wv2-0.2.3.ebuild,v 1.12 2008/04/18 18:48:12 drac Exp $

inherit autotools eutils

DESCRIPTION="Excellent MS Word filter lib, used in most Office suites"
HOMEPAGE="http://wvware.sourceforge.net"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.bz2"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=gnome-extra/libgsf-1.8
	>=media-libs/freetype-2.1
	media-libs/libpng
	media-gfx/imagemagick"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-respectflags.patch \
		"${FILESDIR}"/${P}-gcc43.patch
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."
	dodoc AUTHORS ChangeLog README RELEASE THANKS TODO
}
