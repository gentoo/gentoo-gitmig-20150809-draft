# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xconvers/xconvers-0.8.3.ebuild,v 1.6 2009/09/23 15:25:04 ssuominen Exp $

DESCRIPTION="Hamradio convers client for X/GTK"
HOMEPAGE="http://www.qsl.net/pg4i/linux/xconvers.html"
SRC_URI="http://www.qsl.net/pg4i/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="x11-libs/libXi
	=x11-libs/gtk+-1.2*"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc README ChangeLog || die "dodoc failed"
}
