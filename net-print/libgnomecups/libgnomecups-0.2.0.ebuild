# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/libgnomecups/libgnomecups-0.2.0.ebuild,v 1.9 2005/06/23 08:54:12 gmsoft Exp $

inherit gnome2

DESCRIPTION="GNOME cups library"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="alpha amd64 ~arm hppa ~ia64 ~mips ppc ppc64 sparc x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	net-print/cups"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.29"
