# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xconvers/xconvers-0.8.3.ebuild,v 1.8 2011/03/28 16:52:45 angelos Exp $

EAPI=3

DESCRIPTION="Hamradio convers client for X/GTK"
HOMEPAGE="http://www.qsl.net/pg4i/linux/xconvers.html"
SRC_URI="http://www.qsl.net/pg4i/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND="x11-libs/libXi
	x11-libs/gtk+:1"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README ChangeLog || die "dodoc failed"
}
