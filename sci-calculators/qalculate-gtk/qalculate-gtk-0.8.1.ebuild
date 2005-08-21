# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sci-calculators/qalculate-gtk/qalculate-gtk-0.8.1.ebuild,v 1.2 2005/08/21 17:12:55 weeve Exp $

inherit gnome2

DESCRIPTION="A modern multi-purpose calculator for GNOME"
HOMEPAGE="http://qalculate.sourceforge.net/"
SRC_URI="mirror://sourceforge/qalculate/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~sparc ~x86"
IUSE="gnome nls"

DEPEND="=sci-libs/libqalculate-0.8.1.1
	>=x11-libs/gtk+-2.4
	>=gnome-base/libglade-2.0
	gnome? (
		>=gnome-base/libgnome-2.0
		gnome-extra/yelp )
	nls? ( sys-devel/gettext )"

RDEPEND="app-text/scrollkeeper
	dev-lang/perl
	dev-perl/XML-Parser
	>=dev-util/pkgconfig-0.12.0"

DOCS="AUTHORS ChangeLog NEWS README TODO"
