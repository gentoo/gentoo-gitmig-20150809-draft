# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xdx/xdx-1.2.ebuild,v 1.7 2004/08/04 23:16:26 killsoft Exp $

inherit eutils

DESCRIPTION="GTK2 DX-cluster client"
HOMEPAGE="http://www.qsl.net/pg4i/linux/xdx.html"
SRC_URI="http://www.qsl.net/pg4i/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="x86 ~ppc"
IUSE=""

RDEPEND="virtual/libc
	virtual/x11
	>=x11-libs/gtk+-2.2.4-r1"

DEPEND=">=dev-util/pkgconfig-0.12.0"

src_compile() {
	econf || die "configure failed"
	emake || die "emake failed"
}

src_install() {
	einstall
	dodoc README AUTHORS ChangeLog
	doman xdx.1
	make_desktop_entry xdx Xdx /usr/share/xdx/pixmaps/xdx.xpm HamRadio
}

pkg_postinst() {
	echo
	einfo "To use the rig control feature of xdx, install"
	einfo "media-libs/hamlib and enable hamlib in the"
	einfo "Preferences dialog."
	echo
}

