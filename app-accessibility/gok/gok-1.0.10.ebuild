# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/gok/gok-1.0.10.ebuild,v 1.9 2006/10/19 14:50:56 kloeri Exp $

inherit virtualx gnome2

DESCRIPTION="Gnome Onscreen Keyboard"
HOMEPAGE="http://www.gok.ca/"

LICENSE="LGPL-2"
SLOT="1"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE="doc"

RDEPEND=">=gnome-base/libgnomeui-2
	>=gnome-extra/at-spi-1.5.2
	>=gnome-base/libbonobo-2.5.1
	>=dev-libs/atk-1.3
	>=x11-libs/gtk+-2.3.1
	gnome-base/gail
	>=x11-libs/libwnck-2.13.5
	app-accessibility/gnome-speech
	media-sound/esound
	>=gnome-base/libglade-2
	>=gnome-base/gconf-2
	>=gnome-base/orbit-2
	|| ( (
			x11-libs/libXi
			x11-libs/libX11
			x11-libs/libSM
			x11-libs/libICE )
		virtual/x11 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.34.90
	>=dev-util/pkgconfig-0.9
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

