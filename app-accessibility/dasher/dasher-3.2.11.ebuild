# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/dasher/dasher-3.2.11.ebuild,v 1.5 2004/12/11 14:53:00 kloeri Exp $

inherit gnome2

DESCRIPTION="A text entry interface, driven by continuous pointing gestures"
HOMEPAGE="http://www.inference.phy.cam.ac.uk/dasher/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~amd64 alpha ~hppa ~mips"
IUSE="accessibility gnome"

# The package claims to support 'qte', but it hasn't been tested.
# Any patches from someone who can test it are welcome.
# <leonardop@gentoo.org>
RDEPEND="dev-libs/expat
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	virtual/x11
	gnome? ( >=gnome-base/libgnome-2
		>=gnome-base/gnome-vfs-2
		>=gnome-base/libgnomeui-2 )
	accessibility? ( >=gnome-base/libbonobo-2
		>=gnome-base/orbit-2
		>=gnome-base/libgnomeui-2
		app-accessibility/gnome-speech
		>=gnome-extra/at-spi-1 )"
DEPEND="${RDEPEND}
	>=dev-util/intltool-0.18
	dev-util/pkgconfig
	app-text/scrollkeeper"

G2CONF="${G2CONF} $(use_with gnome) $(use_with accessibility a11y) \
$(use_with accessibility speech)"

DOCS="ABOUT-NLS AUTHORS ChangeLog MAINTAINERS NEWS README"
