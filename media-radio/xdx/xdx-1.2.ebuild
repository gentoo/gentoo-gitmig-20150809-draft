# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xdx/xdx-1.2.ebuild,v 1.2 2004/06/04 04:37:41 rphillips Exp $

inherit eutils

DESCRIPTION="GTK2 DX-cluster client"
HOMEPAGE="http://www.qsl.net/pg4i/linux/xdx.html"
SRC_URI="http://www.qsl.net/pg4i/download/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="virtual/glibc
	virtual/x11
	>=x11-libs/gtk+-2.2.4-r1"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

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
	einfo "media-radio/hamlib and enable hamlib in the"
	einfo "Preferences dialog."
	echo
}
