# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/lumiere/lumiere-0.3.0.ebuild,v 1.4 2003/07/12 21:12:48 aliz Exp $

inherit gnome2 debug

SRC_URI="http://savannah.nongnu.org/download/${PN}/${PN}.pkg/0.3/${P}.tar.gz"

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="gnome2 front-end for mplayer"
HOMEPAGE="http://www.nongnu.org/lumiere"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="media-video/mplayer
	gnome-base/nautilus"

DEPEND=">=dev-util/intltool-0.18
	>=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README"


