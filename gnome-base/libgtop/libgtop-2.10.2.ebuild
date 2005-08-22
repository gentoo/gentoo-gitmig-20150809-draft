# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-base/libgtop/libgtop-2.10.2.ebuild,v 1.2 2005/08/22 23:16:26 agriffis Exp $

inherit gnome2

DESCRIPTION="A library that provides top functionality to applications"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="2"
KEYWORDS="~alpha ~amd64 ~hppa ia64 ~mips ~ppc ~ppc64 sparc ~x86"
IUSE="static"

RDEPEND=">=dev-libs/glib-2.6
	dev-libs/popt"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

DOCS="AUTHORS ChangeLog NEWS README copyright.txt"
USE_DESTDIR="1"
G2CONF="${G2CONF} $(use_enable static)"
