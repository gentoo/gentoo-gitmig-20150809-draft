# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-editors/mlview/mlview-0.7.1.ebuild,v 1.1 2004/11/25 02:22:16 leonardop Exp $

inherit debug gnome2

DESCRIPTION="XML editor for the GNOME environment"
HOMEPAGE="http://www.freespiders.org/projects/gmlview/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"
IUSE="debug"

RDEPEND=">=gnome-base/libgnome-2.6.1
	>=gnome-base/gconf-2.6.2
	>=dev-libs/libxml2-2.6.11
	>=dev-libs/libxslt-1.1.8
	>=dev-libs/glib-2.4.6
	>=x11-libs/gtk+-2.4.3
	>=gnome-base/libglade-2.4
	>=gnome-base/eel-2.6.2
	sys-libs/zlib"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.25
	dev-util/pkgconfig"

DOCS="ABOUT-NLS AUTHORS ChangeLog COPYRIGHT NEWS README"

G2CONF="${G2CONF} $(use_enable debug verbose)"
