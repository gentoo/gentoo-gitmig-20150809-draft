# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gxmms/gxmms-0.3.0.ebuild,v 1.2 2005/10/03 22:18:07 swegener Exp $

inherit gnome2
DESCRIPTION="XMMS applet for Gnome2 panel"

HOMEPAGE="http://www.nongnu.org/gxmms/"

SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE="bmp"
USE_DESTDIR="1"

DEPEND=">=gnome-base/gnome-panel-2.0
	bmp? ( >=media-sound/beep-media-player-0.9.7 )
	!bmp? ( >=media-sound/xmms-1.2.7-r23 )"

pkg_setup() {
	if use bmp; then
		einfo "Building gxmms with bmp support."
	else
		einfo "Building gxmms with xmms support."
		einfo "To enable bmp support set bmp useflag!"
	fi
}

src_compile() {
	cd ${WORKDIR}/${P}

	if use bmp; then
		econf `use_with bmp` || die
	else
		econf --with-xmms || die
	fi

	emake || die "make failed"
}
