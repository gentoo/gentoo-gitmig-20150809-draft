# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gurlchecker/gurlchecker-0.7.3.ebuild,v 1.1 2003/10/18 17:55:56 leonardop Exp $

inherit gnome2

DESCRIPTION="Gnome tool that checks links on web pages/sites"
HOMEPAGE="http://www.nongnu.org/gurlchecker/"
SRC_URI="http://savannah.nongnu.org/download/${PN}/unstable/0.7/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~x86"
SLOT="0"
IUSE=""

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-base/libglade-2
	>=dev-libs/libxml2-2"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="ABOUT-NLS AUTHORS ChangeLog COPYING NEWS README THANKS TODO"

