# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gxmms/gxmms-0.3.0.ebuild,v 1.7 2006/04/24 02:27:19 metalgod Exp $

inherit gnome2
DESCRIPTION="XMMS applet for Gnome2 panel"

HOMEPAGE="http://www.nongnu.org/gxmms/"

SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc sparc x86"
IUSE="bmp"
USE_DESTDIR="1"

DEPEND=">=gnome-base/gnome-panel-2.0
	>=media-sound/xmms-1.2.7-r23"

pkg_setup() {
	einfo "Building gxmms with xmms support."
}

src_compile() {
	cd ${WORKDIR}/${P}

	econf --with-xmms || die

	emake || die "make failed"
}
