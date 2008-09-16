# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-geosciences/gtk-g-rays2/gtk-g-rays2-1.11.ebuild,v 1.2 2008/09/16 20:52:11 hanno Exp $

inherit eutils

DESCRIPTION="GUI for accessing the Wintec WBT 201 / G-Rays 2 GPS device"
HOMEPAGE="http://www.daria.co.uk/gps"
SRC_URI="http://www.zen35309.zen.co.uk/gps/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="gnome-base/libglade"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}/gtk-g-rays2-1.11-makecheck.diff" || die "epatch failed"
	rm -rf debian/gtk-g-rays2
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
	dodoc README AUTHORS ChangeLog || die "dodoc failed"
}
