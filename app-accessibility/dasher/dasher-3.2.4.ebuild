# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/dasher/dasher-3.2.4.ebuild,v 1.6 2004/05/31 18:45:21 vapier Exp $

inherit gnome2

DESCRIPTION="A text entry interface, driven by continuous pointing gestures"
HOMEPAGE="http://www.inference.phy.cam.ac.uk/dasher/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc"
IUSE="accessibility gnome nls"

# The archive claims 'qte' support, but wont compile with QT
# Need to wait for upstream <obz@gentoo.org>
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

G2CONF="${G2CONF} $(use_enable nls) $(use_enable gnome)"
G2CONF="${G2CONF} $(use_enable accessibility a11y)"
G2CONF="${G2CONF} $(use_enable accessibility speech)"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
