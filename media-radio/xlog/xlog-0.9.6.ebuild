# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xlog/xlog-0.9.6.ebuild,v 1.4 2004/08/04 23:18:38 killsoft Exp $

inherit eutils

DESCRIPTION="GTK+ Amateur Radio logging program"
HOMEPAGE="http://www.qsl.net/pg4i/linux/xlog.html"
SRC_URI="http://www.qsl.net/pg4i/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="virtual/libc
	virtual/x11
	>=gnome-base/libgnomeprint-2.4.2
	>=x11-libs/gtk+-2.4.0-r1
	media-libs/hamlib"

DEPEND="sys-devel/libtool
	>=app-doc/doxygen-1.3.5-r1
	>=dev-util/pkgconfig-0.12.0"

src_compile() {
	econf --enable-hamlib \
		|| die "configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall || die
	make_desktop_entry xlog XLog xlog.xpm HamRadio
}

