# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xzgv/xzgv-0.9.ebuild,v 1.5 2011/03/28 19:10:29 ssuominen Exp $

EAPI=1
inherit eutils toolchain-funcs

DESCRIPTION="Fast and simple GTK+ image viewer"
HOMEPAGE="http://sourceforge.net/projects/xzgv"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc64 x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	# Fix linking order to work with -Wl,--as-needed and respect custom cflags.
	epatch "${FILESDIR}"/${P}-asneeded-and-cflags.patch
}

src_compile() {
	emake CC="$(tc-getCC)" || die "emake failed."
}

src_install() {
	emake PREFIX="${D}/usr" install || die "emake install failed."
	dodoc AUTHORS ChangeLog NEWS README TODO
}
