# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnopernicus/gnopernicus-0.7.3.ebuild,v 1.1 2004/03/17 22:21:01 leonardop Exp $

inherit gnome2

DESCRIPTION="Software tools for blind and visually impaired in Gnome 2"
HOMEPAGE="http://www.baum.ro/gnopernicus.html"

IUSE="ipv6"
SLOT="0"
KEYWORDS="x86 ~sparc ~hppa ~alpha ~ia64 ~ppc ~amd64"
LICENSE="LGPL-2"

# libgail-gnome is only required during runtime

RDEPEND=">=gnome-base/gconf-1.1.5
	>=dev-libs/popt-1.5
	>=gnome-base/libgnome-1.102
	>=gnome-base/libgnomeui-1.106
	>=dev-libs/glib-1.3.12
	>=x11-libs/gtk+-1.3
	>=dev-libs/libxml2-2.4.6
	>=gnome-base/libglade-1.99.4
	>=gnome-extra/at-spi-1.1.6
	>=app-accessibility/gnome-speech-0.3
	>=app-accessibility/gnome-mag-0.9
	>=gnome-extra/libgail-gnome-1.0
	virtual/x11"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

G2CONF="${G2CONF} \
	--with-default-fonts-path=${D}/usr/share/fonts/default/Type1 \
	$(use_enable ipv6)"

DOCS="AUTHORS ChangeLog COPYING NEWS README"

