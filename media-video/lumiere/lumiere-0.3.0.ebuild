# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/lumiere/lumiere-0.3.0.ebuild,v 1.1 2003/01/20 16:35:27 lu_zero Exp $

inherit gnome2 debug

SRC_URI="http://brain.shacknet.nu/${P}.tar.gz"

IUSE=""
S=${WORKDIR}/${P}
DESCRIPTION="gnome2 front-end for mplayer"
HOMEPAGE="http://brain.shacknet.nu/lumiere.html"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"

RDEPEND="media-video/mplayer
	gnome-base/nautilus"

DEPEND=">=dev-util/intltool-0.18
	>=dev-util/pkgconfig-0.12.0
	${RDEPEND}"

DOCS="AUTHORS ChangeLog COPYING INSTALL NEWS README"


