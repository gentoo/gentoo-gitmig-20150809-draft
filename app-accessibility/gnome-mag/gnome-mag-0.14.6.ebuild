# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gnome-mag/gnome-mag-0.14.6.ebuild,v 1.1 2007/07/21 22:30:58 eva Exp $

inherit virtualx gnome2

DESCRIPTION="Gnome magnification service definition"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND=">=dev-libs/glib-2.11.1
	>=x11-libs/gtk+-2.6"

# for future use ?
#RDEPEND="${RDEPEND}
#	>=dev-python/pygtk-2.6
#	>=dev-python/gnome-python-2.10
#	>=gnome-base/gnome-desktop-2.10"

RDEPEND="${RDEPEND}
	>=gnome-base/libbonobo-1.107
	>=gnome-extra/at-spi-1.5.2
	>=gnome-base/orbit-2.3.100

	x11-libs/libX11
	x11-libs/libXtst
	x11-libs/libXdamage
	x11-libs/libXfixes
	x11-libs/libXcomposite"

DEPEND="${RDEPEND}
	>=dev-util/pkgconfig-0.9
	>=dev-util/intltool-0.35

	x11-proto/xextproto
	x11-proto/xproto"

DOCS="AUTHORS ChangeLog NEWS README"

src_test() {
	echo "colorblind/data/colorblind-applet.schemas.in" >> ${S}/po/POTFILES.skip
	Xmake check || die
}

