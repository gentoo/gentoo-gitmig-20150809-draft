# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-libs/libsexy/libsexy-0.1.4.ebuild,v 1.1 2005/12/23 20:52:49 compnerd Exp $

inherit gnome2

DESCRIPTION="Sexy GTK+ Widgets"
HOMEPAGE="http://www.chipx86.com/wiki/Libsexy"
SRC_URI="http://osiris.chipx86.com/projects/libsexy/releases/${P}.tar.gz"

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="doc"

RDEPEND=">=x11-libs/gtk+-2.6
		 >=app-text/enchant-0.4.0
		 >=app-text/iso-codes-0.35"
DEPEND="${RDEPEND}
		dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README"
USE_DESTDIR="1"

pkg_config() {
	G2CONF="${G2CONF} --enable-enchant"
}
