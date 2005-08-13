# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnopernicus/gnopernicus-0.10.9.ebuild,v 1.10 2005/08/13 11:36:57 metalgod Exp $

inherit gnome2

DESCRIPTION="Software tools for blind and visually impaired in Gnome 2"
HOMEPAGE="http://www.baum.ro/gnopernicus.html"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 hppa ~ia64 ppc ppc64 sparc x86"
IUSE="brltty doc ipv6 static"

RDEPEND=">=gnome-base/gconf-2.6.1
	>=dev-libs/popt-1.5
	>=gnome-base/libgnome-2.6
	>=gnome-base/libgnomeui-2.6.1
	>=dev-libs/glib-2.4.1
	>=x11-libs/gtk+-2.4.1
	>=dev-libs/libxml2-2.6.7
	>=gnome-base/libglade-2.3.6
	>=gnome-extra/at-spi-1.5.4
	>=app-accessibility/gnome-speech-0.3.5
	>=app-accessibility/gnome-mag-0.11.7
	>=gnome-extra/libgail-gnome-1.0
	virtual/x11
	brltty? ( >=app-accessibility/brltty-3.6 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.29
	dev-util/pkgconfig
	app-text/scrollkeeper
	doc? ( >=dev-util/gtk-doc-1 )"

G2CONF="${G2CONF} $(use_enable ipv6) $(use_enable brltty) \
$(use_enable static) --with-default-fonts-path=${D}/usr/share/fonts/Type1"

DOCS="AUTHORS ChangeLog NEWS README"

