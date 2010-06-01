# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/selectwm/selectwm-0.4.1.ebuild,v 1.11 2010/06/01 17:00:17 xarthisius Exp $

inherit autotools eutils

DESCRIPTION="window manager selector tool"
HOMEPAGE="http://ordiluc.net/selectwm"
SRC_URI="http://ordiluc.net/selectwm/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="amd64 ppc sparc x86 ~x86-fbsd"
IUSE="nls"

RDEPEND=">=x11-libs/gtk+-2.0.0
	>=dev-libs/glib-2.0.0"
DEPEND="$RDEPEND
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-enable-deprecated-gtk.patch \
		"${FILESDIR}"/${P}-glibc-2.10.patch \
		"${FILESDIR}"/${P}-nostrip.patch
	eautoreconf
}

src_compile() {
	econf \
		--program-suffix=2 \
		$(use_enable nls)
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS README sample.xinitrc || die
}
