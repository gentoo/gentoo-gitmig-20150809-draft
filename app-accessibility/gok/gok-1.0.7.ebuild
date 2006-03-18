# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gok/gok-1.0.7.ebuild,v 1.1 2006/03/18 13:01:22 allanonjl Exp $

inherit virtualx gnome2

DESCRIPTION="Gnome Onscreen Keyboard"
HOMEPAGE="http://www.gok.ca/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="doc"

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
	|| ( (
			x11-libs/libXi
			x11-libs/libX11
			x11-libs/libSM
			x11-libs/libICE )
		virtual/x11 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.27.3
	dev-util/pkgconfig
	app-text/scrollkeeper
	doc? ( >=dev-util/gtk-doc-1 )
	|| ( (
			x11-libs/libXt
			x11-proto/inputproto
			x11-proto/kbproto
			x11-proto/xproto )
		virtual/x11 )"

DOCS="AUTHORS ChangeLog NEWS README"

# So it doesn't break when building kbd files
MAKEOPTS="${MAKEOPTS} -j1"

src_test() {
	addpredict /
	Xmake check || die
}
