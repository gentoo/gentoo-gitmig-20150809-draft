# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/wv2/wv2-0.2.3.ebuild,v 1.11 2007/02/12 03:52:59 jer Exp $

inherit eutils autotools

DESCRIPTION="Excellent MS Word filter lib, used in most Office suites"
SRC_URI="mirror://sourceforge/wvware/${P}.tar.bz2"
HOMEPAGE="http://wvware.sourceforge.net/"

KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE=""
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=gnome-extra/libgsf-1.8.0
	>=media-libs/freetype-2.1
	sys-libs/zlib
	media-libs/libpng"

RDEPEND="${DEPEND}
	media-gfx/imagemagick"

src_unpack() {
	unpack ${A}
	cd ${S}

	epatch "${FILESDIR}/${P}-respectflags.patch" || die

	eautoreconf
}

src_install() {
	einstall || die
}
