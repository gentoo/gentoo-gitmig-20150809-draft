# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xconvers/xconvers-0.8.3.ebuild,v 1.4 2007/07/22 09:10:24 dberkholz Exp $

DESCRIPTION="Hamradio convers client for X/GTK"
HOMEPAGE="http://www.qsl.net/pg4i/linux/xconvers.html"
SRC_URI="http://www.qsl.net/pg4i/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

DEPEND="virtual/libc
	x11-libs/libXi
	>=x11-libs/gtk+-1.2.0"

src_compile() {

	econf || die "configure failed"
	emake || die "emake failed"
}

src_install() {

	make DESTDIR="${D}" install || die "install failed"
	dodoc README ChangeLog || die "dodoc failed"
}
