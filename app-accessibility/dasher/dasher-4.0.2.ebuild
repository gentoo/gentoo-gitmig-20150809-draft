# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/dasher/dasher-4.0.2.ebuild,v 1.10 2006/10/21 02:03:11 agriffis Exp $

inherit eutils gnome2 autotools

DESCRIPTION="A text entry interface, driven by continuous pointing gestures"
HOMEPAGE="http://www.inference.phy.cam.ac.uk/dasher/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86"

IUSE="accessibility gnome cairo"

# The package claims to support 'qte', but it hasn't been tested.
# Any patches from someone who can test it are welcome.
# <leonardop@gentoo.org>
RDEPEND="dev-libs/expat
	>=x11-libs/gtk+-2.6
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=dev-libs/glib-2
	>=x11-libs/libwnck-1
	|| ( (
			x11-libs/libX11
			x11-libs/libXtst )
		virtual/x11 )
	gnome? (
		>=gnome-base/libgnome-2
		>=gnome-base/libgnomeui-2
		>=gnome-base/gnome-vfs-2 )
	accessibility? (
		app-accessibility/gnome-speech
		>=gnome-base/libbonobo-2
		>=gnome-base/orbit-2
		>=gnome-base/libgnomeui-2
		>=gnome-extra/at-spi-1 )
	cairo? ( >=x11-libs/gtk+-2.8 )"

DEPEND="${RDEPEND}
	|| ( (
			x11-proto/xextproto
			x11-proto/xproto
			x11-libs/libXt )
		virtual/x11 )
	>=dev-util/intltool-0.28
	>=dev-util/pkgconfig-0.9
	app-text/scrollkeeper"

DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"


pkg_setup() {
	G2CONF="$(use_with gnome) \
		$(use_enable accessibility a11y)   \
		$(use_enable accessibility speech) \
		$(use_with cairo)"
}

src_unpack() {
	gnome2_src_unpack

	# Fix compilation with USE=-gnome (bug #132510)
	epatch "${FILESDIR}"/${P}-without_gnome.patch

	# fix configure flags
	epatch "${FILESDIR}"/${P}-fix_enable_flags.patch

	eautoreconf
}
