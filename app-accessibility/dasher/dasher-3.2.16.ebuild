# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-accessibility/dasher/dasher-3.2.16.ebuild,v 1.1 2005/08/24 10:54:05 leonardop Exp $

inherit eutils gnome2

DESCRIPTION="A text entry interface, driven by continuous pointing gestures"
HOMEPAGE="http://www.inference.phy.cam.ac.uk/dasher/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="accessibility gnome"

# The package claims to support 'qte', but it hasn't been tested.
# Any patches from someone who can test it are welcome.
# <leonardop@gentoo.org>
RDEPEND=">=x11-libs/gtk+-2
	>=gnome-base/gconf-2
	>=gnome-base/libglade-2
	>=x11-libs/libwnck-1
	dev-libs/expat
	>=dev-libs/glib-2
	virtual/x11
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
	>=dev-util/intltool-0.28
	>=dev-util/pkgconfig-0.9
	app-text/scrollkeeper"

USE_DESTDIR="1"
DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"


pkg_setup() {
	G2CONF="$(use_with gnome) $(use_with accessibility a11y) \
		$(use_with accessibility speech) --without-cairo"
	# cairo switch disabled until gtk+ 2.7 or better is available and
	# not hard-masked
}

src_unpack() {
	unpack "${A}"
	cd "${S}"

	# Poor pointer management causes segfault at startup
	epatch ${FILESDIR}/${PN}-3.2.15-buildwindowtree.patch

	local makefiles="Data/Help/Gnome/omf.make"
	for f in $(find Data/Help/Gnome -name Makefile.in); do
		makefiles="${makefiles} $f"
	done
	gnome2_omf_fix $makefiles
}
