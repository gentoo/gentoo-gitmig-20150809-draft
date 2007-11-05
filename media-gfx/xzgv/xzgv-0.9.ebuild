# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/xzgv/xzgv-0.9.ebuild,v 1.2 2007/11/05 21:41:29 drac Exp $

inherit eutils toolchain-funcs

DESCRIPTION="Fast and simple GTK+ image viewer"
HOMEPAGE="http://sourceforge.net/projects/xzgv"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2"
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
