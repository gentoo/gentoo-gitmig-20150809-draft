# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/gnotime/gnotime-2.1.7.ebuild,v 1.2 2004/03/19 14:17:57 weeve Exp $

inherit gnome2

DESCRIPTION="A utility for tracking the amount of time spent on activities, and calculating data, such as pay rates, from those times."
HOMEPAGE="http://gttr.sourceforge.net/"
SRC_URI="mirror://sourceforge/gttr/${P}.tar.gz"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

RDEPEND=">=gnome-base/libgnome-2.0
	>=gnome-base/libgnomeui-2.0.3
	>=gnome-base/libglade-2.0
	=gnome-extra/libgtkhtml-2*
	>=gnome-base/gconf-2.0
	dev-libs/libxml2
	dev-util/guile
	dev-libs/popt"

DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool
	>=app-text/scrollkeeper-0.3.11"

DOCS="AUTHORS COPYING ChangeLog INSTALL NEWS README TODO"

G2CONF="${G2CONF} --disable-schemas-install"

