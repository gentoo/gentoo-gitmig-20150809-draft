# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/gxmms/gxmms-0.1.0.ebuild,v 1.4 2004/03/26 16:17:15 eradicator Exp $

inherit gnome2
DESCRIPTION="XMMS applet for Gnome2 panel"

HOMEPAGE="http://www.nongnu.org/gxmms/"

SRC_URI="http://savannah.nongnu.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~amd64 ~sparc"
IUSE=""
USE_DESTDIR="1"

DEPEND=">=media-sound/xmms-1.2.7-r23
	>=gnome-base/gnome-panel-2.0"
