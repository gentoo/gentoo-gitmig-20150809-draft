# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-themes/gtk-qt-engine/gtk-qt-engine-0.5.ebuild,v 1.4 2004/09/03 13:27:07 brad Exp $

inherit gtk-engines2 eutils kde-functions

IUSE="arts"
DESCRIPTION="GTK+2 Qt Theme Engine"
HOMEPAGE="http://xserver.freedesktop.org/Software/gtk-qt"
SRC_URI="http://xserver.freedesktop.org/Software/gtk-qt/${P}.tar.bz2"
KEYWORDS="~x86"
LICENSE="GPL-2"
SLOT="2"

DEPEND="${DEPEND}
	dev-util/pkgconfig
	>=x11-libs/gtk+-2.2.0
	>=x11-libs/qt-3.0.3
	arts? ( kde-base/arts )"

src_unpack() {
	unpack ${A} || die
	cd ${S}
	epatch ${FILESDIR}/scrollbars.patch
}

src_compile() {
	local myconf
	use arts && myconf="$myconf --with-arts" || myconf="$myconf --without-arts"

	set-qtdir 3
	econf $myconf || die
	emake || die
}
