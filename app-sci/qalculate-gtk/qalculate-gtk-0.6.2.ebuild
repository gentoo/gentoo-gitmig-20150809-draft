# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-sci/qalculate-gtk/qalculate-gtk-0.6.2.ebuild,v 1.1 2004/07/22 13:24:52 ribosome Exp $

inherit gnome2 flag-o-matic

DESCRIPTION="A modern multi-purpose desktop calculator"
HOMEPAGE="http://qalculate.sourceforge.net/"
SRC_URI="mirror://sourceforge/qalculate/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"

KEYWORDS="x86"
IUSE="nls gnome"

RDEPEND=">=x11-libs/gtk+-2.3
	>=gnome-base/libglade-2
	>=dev-libs/cln-1.1
	>=media-gfx/gnuplot-3.7
	dev-libs/libxml2
	net-misc/wget
	gnome? ( >=gnome-base/libgnome-2.2.0 )"

DEPEND="${RDEPEND}
	dev-perl/XML-Parser
	>=dev-util/pkgconfig-0.12.0
	app-text/scrollkeeper
	nls? ( sys-devel/gettext )"

DOCS="AUTHORS COPYING ChangeLog NEWS README INSTALL TODO"

replace-flags -Os -O2


