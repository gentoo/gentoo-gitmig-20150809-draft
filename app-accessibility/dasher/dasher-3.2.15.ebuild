# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/dasher/dasher-3.2.15.ebuild,v 1.13 2006/03/16 22:30:37 allanonjl Exp $

inherit eutils gnome2

DESCRIPTION="A text entry interface, driven by continuous pointing gestures"
HOMEPAGE="http://www.inference.phy.cam.ac.uk/dasher/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"

IUSE="accessibility gnome"

# The package claims to support 'qte', but it hasn't been tested.
# Any patches from someone who can test it are welcome.
# <leonardop@gentoo.org>
RDEPEND="dev-libs/expat
	>=dev-libs/glib-2
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=x11-libs/libwnck-1
	|| ( (
			x11-libs/libX11 )
		virtual/x11 )
	gnome? ( >=gnome-base/libgnome-2
		>=gnome-base/gnome-vfs-2
		>=gnome-base/libgnomeui-2 )
	accessibility? ( >=gnome-base/libbonobo-2
		>=gnome-base/orbit-2
		>=gnome-base/libgnomeui-2
		app-accessibility/gnome-speech
		>=gnome-extra/at-spi-1 )"
DEPEND="${RDEPEND}
	|| ( (
			x11-proto/xextproto
			x11-proto/xproto
			x11-libs/libXt )
		virtual/x11 )
	>=dev-util/intltool-0.18
	dev-util/pkgconfig
	app-text/scrollkeeper"

G2CONF="${G2CONF} $(use_with gnome) \
$(use_with accessibility a11y) $(use_with accessibility speech)"

DOCS="ABOUT-NLS AUTHORS ChangeLog MAINTAINERS NEWS README"

src_unpack() {
	unpack ${A}
	cd ${S}

	# Fix test phase for the xtst library
	epatch ${FILESDIR}/${PN}-3.2.11-xtst_fix.patch
	# Poor pointer management causes segfault at startup
	epatch ${FILESDIR}/${P}-buildwindowtree.patch
}
