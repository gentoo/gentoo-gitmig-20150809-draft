# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/byzanz/byzanz-0.2.2.ebuild,v 1.1 2010/10/06 19:03:07 eva Exp $

GCONF_DEBUG="no"

inherit gnome2

DESCRIPTION="Screencasting program that saves casts as GIF files"
HOMEPAGE="http://people.freedesktop.org/~company/byzanz/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-libs/libXdamage-1.0
		>=dev-libs/glib-2.16
		>=x11-libs/gtk+-2.17.10
		>=gnome-base/gconf-2.10
		>=gnome-base/gnome-panel-2.10
		>=media-libs/gst-plugins-base-0.10.24
		>=x11-libs/cairo-1.8.10"
DEPEND="dev-util/pkgconfig
		dev-util/intltool
		>=x11-proto/damageproto-1.0
		${RDEPEND}"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
