# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/dasher/dasher-3.2.10.ebuild,v 1.1 2004/04/28 09:44:21 leonardop Exp $

inherit gnome2

DESCRIPTION="A text entry interface, driven by continuous pointing gestures"
HOMEPAGE="http://www.inference.phy.cam.ac.uk/dasher/"

IUSE="accessibility gnome"
SLOT="0"
KEYWORDS="~x86"
LICENSE="GPL-2"

# The package claims to support 'qte', but it hasn't been tested.
# Any patches from someone who can test it are welcome.
# <leonardop@gentoo.org>
RDEPEND="dev-libs/expat
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	gnome? ( >=gnome-base/libgnome-2
		>=gnome-base/gnome-vfs-2
		>=gnome-base/libgnomeui-2 )
	accessibility? ( >=gnome-base/libbonobo-2
		>=gnome-base/ORBit2-2
		>=gnome-base/libgnomeui-2
		app-accessibility/gnome-speech
		>=gnome-extra/at-spi-1 )"

DEPEND="${RDEPEND}
	>=dev-util/intltool-0.18
	dev-util/pkgconfig
	app-text/scrollkeeper"

G2CONF="${G2CONF} $(use_with gnome)"
G2CONF="${G2CONF} $(use_with accessibility a11y)"
G2CONF="${G2CONF} $(use_with accessibility speech)"

DOCS="ABOUT-NLS AUTHORS ChangeLog COPYING MAINTAINERS NEWS README"
