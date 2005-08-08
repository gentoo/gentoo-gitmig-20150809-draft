# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gok/gok-1.0.5.ebuild,v 1.8 2005/08/08 08:38:49 corsair Exp $

inherit gnome2

DESCRIPTION="Gnome Onscreen Keyboard"
HOMEPAGE="http://www.gok.ca/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha ~amd64 hppa ~ia64 ppc ppc64 sparc x86"
IUSE="doc static"

RDEPEND=">=x11-libs/gtk+-2.3.1
	>=gnome-base/gconf-2
	>=gnome-base/libgnomeui-2
	>=gnome-base/libbonobo-2.5.1
	>=gnome-base/libglade-2
	>=dev-libs/atk-1.3
	gnome-base/gail
	media-sound/esound
	x11-libs/libwnck
	>=gnome-extra/at-spi-1.5.2
	>=gnome-base/orbit-2
	app-accessibility/gnome-speech
	virtual/x11"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.27.3
	dev-util/pkgconfig
	app-text/scrollkeeper
	doc? ( >=dev-util/gtk-doc-1 )"

DOCS="AUTHORS ChangeLog NEWS README"

G2CONF="${G2CONF} $(use_enable static)"

# So it doesn't break when building kbd files
MAKEOPTS="${MAKEOPTS} -j1"
