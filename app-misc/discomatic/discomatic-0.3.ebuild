# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-misc/discomatic/discomatic-0.3.ebuild,v 1.4 2004/10/01 12:38:59 pyrania Exp $

inherit gnome2

DESCRIPTION="GTK+ CD-ROM archiving tool for mastering and burning multiple CD-ROM"
HOMEPAGE="http://discomatic.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.2
	>=x11-libs/gtk+-2.2"
DEPEND="${RDEPEND}
	 dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog INSTALL NEWS README* TODO"
