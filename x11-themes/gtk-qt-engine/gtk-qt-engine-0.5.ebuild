# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-qt-engine/gtk-qt-engine-0.5.ebuild,v 1.1 2004/08/23 05:38:55 brad Exp $

inherit gtk-engines2 eutils kde-functions

DESCRIPTION="GTK+2 Qt Theme Engine"
HOMEPAGE="http://xserver.freedesktop.org/Software/gtk-qt"
SRC_URI="http://xserver.freedesktop.org/Software/gtk-qt/${P}.tar.bz2"
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="2"

DEPEND="${DEPEND}
	dev-util/pkgconfig
	>=x11-themes/qtpixmap-0.25"

src_unpack() {
	unpack ${A} || die
}

src_compile() {
	set-qtdir 3
	econf || die
	emake || die
}
