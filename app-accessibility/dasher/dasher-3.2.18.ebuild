# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/dasher/dasher-3.2.18.ebuild,v 1.11 2006/04/09 04:34:57 halcy0n Exp $

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
	>=x11-libs/gtk+-2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=dev-libs/glib-2
	>=x11-libs/libwnck-1
	|| ( (
			x11-libs/libX11 )
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
		>=gnome-extra/at-spi-1 )"

DEPEND="${RDEPEND}
	|| ( (
			x11-proto/xextproto
			x11-proto/xproto
			x11-libs/libXt )
		virtual/x11 )

	>=dev-util/intltool-0.28
	>=dev-util/pkgconfig-0.9
	app-text/scrollkeeper"

USE_DESTDIR="1"
DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"


pkg_setup() {
	# cairo switch disabled until gtk+ 2.7 or better is available and
	# not hard-masked
	G2CONF="$(use_with gnome) \
		$(use_with accessibility a11y)   \
		$(use_with accessibility speech) \
		--without-cairo"
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Poor pointer management causes segfault at startup
	epatch "${FILESDIR}"/${PN}-3.2.15-buildwindowtree.patch

	epatch "${FILESDIR}"/${P}-gcc41.patch

	gnome2_omf_fix Data/Help/Gnome/*/Makefile.in
}
