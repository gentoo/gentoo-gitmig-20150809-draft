# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-radio/xdx/xdx-1.2.ebuild,v 1.11 2007/11/09 14:30:51 drac Exp $

inherit eutils

DESCRIPTION="GTK2 DX-cluster client"
HOMEPAGE="http://www.qsl.net/pg4i/linux/xdx.html"
SRC_URI="http://www.qsl.net/pg4i/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

RDEPEND=">=x11-libs/gtk+-2.2.4-r1"
DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS ChangeLog
	doman xdx.1
	make_desktop_entry xdx Xdx /usr/share/xdx/pixmaps/xdx.xpm HamRadio
}

pkg_postinst() {
	echo
	elog "To use the rig control feature of xdx, install"
	elog "media-libs/hamlib and enable hamlib in the"
	elog "Preferences dialog."
	echo
}
