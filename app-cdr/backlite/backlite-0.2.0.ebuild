# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/backlite/backlite-0.2.0.ebuild,v 1.1 2009/12/07 20:55:40 billie Exp $

EAPI="2"

inherit qt4

DESCRIPTION="backlite is a pure QT4 version of k9copy"
HOMEPAGE="http://k9copy.sourceforge.net/"
SRC_URI="mirror://sourceforge/k9copy/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="mplayer"

# According to the author of backlite/k9copy libdvdread and libdvdnav are
# bundled internal because newer versions produce bad DVD copies.
# This will be fixed later.
# DEPEND="media-libs/libdvdread"

DEPEND=">=media-libs/libmpeg2-0.5.1
	x11-libs/qt-gui:4[dbus]
	|| ( x11-libs/qt-phonon:4 media-sound/phonon )"

RDEPEND="${DEPEND}
	media-video/dvdauthor
	mplayer? ( media-video/mplayer )"

src_configure() {
	eqmake4 backlite.pro PREFIX="${D}"/usr
}

src_install() {
	emake install || die "emake install failed"
}
