# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/qalculate/qalculate-0.7.1.ebuild,v 1.1 2005/01/05 09:02:57 phosphan Exp $

inherit gnome2 flag-o-matic

DESCRIPTION="A modern multi-purpose desktop calculator"
HOMEPAGE="http://qalculate.sourceforge.net/"
SRC_URI="mirror://sourceforge/qalculate/${P}.tar.gz"
SLOT="0"
LICENSE="GPL-2"

KEYWORDS="~x86"
IUSE="nls gnome"

RDEPEND=">=x11-libs/gtk+-2.3
	>=gnome-base/libglade-2
	>=sci-libs/cln-1.1
	>=media-gfx/gnuplot-3.7
	dev-libs/libxml2
	net-misc/wget
	sys-libs/readline
	gnome? ( >=gnome-base/libgnome-2.2.0 )"

DEPEND="${RDEPEND}
	dev-perl/XML-Parser
	>=dev-util/pkgconfig-0.12.0
	app-text/scrollkeeper
	nls? ( sys-devel/gettext )"

DOCS="AUTHORS ChangeLog NEWS README INSTALL TODO"

replace-flags -Os -O2
