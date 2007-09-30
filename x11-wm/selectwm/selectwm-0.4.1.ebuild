# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/selectwm/selectwm-0.4.1.ebuild,v 1.8 2007/09/30 20:09:52 coldwind Exp $

inherit eutils

DESCRIPTION="window manager selector tool"
HOMEPAGE="http://ordiluc.net/selectwm"
SRC_URI="http://ordiluc.net/selectwm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64 ppc sparc x86"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0"
DEPEND="$RDEPEND
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-enable-deprecated-gtk.patch
}

src_compile() {
	econf \
		--program-suffix=2 \
		$(use_enable nls) || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	einstall || die "einstall failed"
	dodoc AUTHORS README
}
