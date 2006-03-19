# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xconvers/xconvers-0.8.2.ebuild,v 1.6 2006/03/19 00:16:16 joshuabaergen Exp $

inherit eutils

DESCRIPTION="Hamradio convers client for X/GTK"
HOMEPAGE="http://www.qsl.net/pg4i/linux/xconvers.html"
SRC_URI="http://www.qsl.net/pg4i/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/libc
	|| ( x11-libs/libXi virtual/x11 )
	>=x11-libs/gtk+-1.2.0"

src_compile() {
	econf || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
	dodoc README
	make_desktop_entry xconvers Xconvers xconvers.png HamRadio
}

