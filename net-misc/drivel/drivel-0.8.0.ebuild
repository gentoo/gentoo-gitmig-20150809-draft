# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/drivel/drivel-0.8.0.ebuild,v 1.4 2003/09/05 22:01:48 msterret Exp $

IUSE=""

inherit gnome2

S=${WORKDIR}/${P}
DESCRIPTION="GTK2-based client for writing LiveJournal entries"
SRC_URI="ftp://ftp.sourceforge.net/pub/sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~ppc x86"

RDEPEND=">=dev-libs/glib-2.0.6
	>=gnome-2*"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS  README"

