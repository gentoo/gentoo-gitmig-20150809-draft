# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-sendto/nautilus-sendto-0.5.ebuild,v 1.1 2006/03/23 18:49:09 compnerd Exp $

inherit gnome2 eutils autotools

DESCRIPTION="A nautilus extension for sending files to locations"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="bluetooth eds gaim"

RDEPEND=">=dev-libs/glib-2.4
		>=x11-libs/gtk+-2.4
		>=gnome-base/libglade-2.5.1
		>=gnome-base/libbonobo-2.13.0
		>=gnome-base/libbonoboui-2.13.0
		>=gnome-base/libgnome-2.13.0
		>=gnome-base/libgnomeui-2.13.0
		>=gnome-base/nautilus-2.13.3
		bluetooth? ( >=net-wireless/gnome-bluetooth-0.6 )
		eds? ( >=gnome-extra/evolution-data-server-1.5.3 )
		gaim? ( =net-im/gaim-1.5* )"
DEPEND="${RDEPEND}
		dev-util/pkgconfig
		sys-devel/gettext
		dev-util/intltool"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} \
			$(use_enable bluetooth) \
			$(use_enable eds evolution)
			$(use_enable gaim)"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Convert autodetection into hard options
	epatch ${FILESDIR}/${PN}-0.5-configure-options.patch

	# Oh the joys of autotools
	eautoreconf
}

pkg_postinst() {
	gnome2_pkg_postinst

	if use gaim ; then
		einfo "To enable SendTo support in GAIM, you must enable the plugin in GAIM"
		einfo "Check Tools -> Preferences -> Plugins in the GAIM menu."
	fi
}
