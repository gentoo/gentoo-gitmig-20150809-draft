# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/lumiere/lumiere-0.4.ebuild,v 1.6 2004/07/14 21:58:43 agriffis Exp $

inherit gnome2 debug

DESCRIPTION="gnome2 front-end for mplayer"
HOMEPAGE="http://www.nongnu.org/lumiere"
SRC_URI="http://savannah.nongnu.org/download/${PN}/${PN}.pkg/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND="media-video/mplayer
	gnome-base/nautilus"
DEPEND=">=dev-util/intltool-0.18
	>=dev-util/pkgconfig-0.12.0
	>=x11-libs/gtkglarea-1.99.0
	>=media-libs/xine-lib-1_beta2
	>=x11-libs/gtkglarea-1.99.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README"
