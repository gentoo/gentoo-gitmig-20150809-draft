# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libgee/libgee-0.1.5.ebuild,v 1.1 2009/05/17 22:33:55 eva Exp $

inherit gnome2

DESCRIPTION="GObject-based interfaces and classes for commonly used data structures."
HOMEPAGE="http://live.gnome.org/Libgee"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2.10"
DEPEND="${RDEPEND}
	dev-lang/vala
	dev-util/pkgconfig"
