# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/libgnomecups/libgnomecups-0.1.6.ebuild,v 1.3 2003/09/12 17:09:06 agriffis Exp $

inherit gnome2

DESCRIPTION="GNOME cups library"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	net-print/cups"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.20"
