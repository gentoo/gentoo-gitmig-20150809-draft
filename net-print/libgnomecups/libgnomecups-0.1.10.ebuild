# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-print/libgnomecups/libgnomecups-0.1.10.ebuild,v 1.2 2004/11/08 19:09:48 vapier Exp $

inherit gnome2

DESCRIPTION="GNOME cups library"
HOMEPAGE="http://www.gnome.org"

LICENSE="GPL-2 LGPL-2.1"
SLOT="0"
KEYWORDS="~x86 ~ppc ~alpha ~sparc ~hppa ~ia64 ~amd64 ~mips ~arm"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	net-print/cups"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	>=dev-util/intltool-0.20"
