# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/gnome-extra/nautilus-sendto/nautilus-sendto-0.10.ebuild,v 1.1 2007/03/22 20:29:06 compnerd Exp $

inherit gnome2 eutils autotools

DESCRIPTION="A nautilus extension for sending files to locations"
HOMEPAGE="http://www.gnome.org/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE="bluetooth eds gaim gajim sylpheed thunderbird"

RDEPEND=">=x11-libs/gtk+-2.4
		 >=dev-libs/glib-2.6
		 >=gnome-base/libglade-2.5.1
		 >=gnome-base/libbonobo-2.13.0
		 >=gnome-base/libbonoboui-2.13.0
		 >=gnome-base/libgnome-2.13.0
		 >=gnome-base/libgnomeui-2.13.0
		 >=gnome-base/nautilus-2.13.3
		 >=gnome-base/gconf-2.13.0
		 ||	(
				>=dev-libs/dbus-glib-0.71
				( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.60 )
			)
		 bluetooth? ( >=net-wireless/gnome-bluetooth-0.6 )
		 eds? ( >=gnome-extra/evolution-data-server-1.5.3 )
		 gaim? ( >=net-im/gaim-1.5.0 )
		 gajim? ( net-im/gajim )
		 sylpheed?	( ||	(
								mail-client/sylpheed
								mail-client/claws-mail
								mail-client/sylpheed-claws
							)
					)
		 thunderbird? ( mail-client/mozilla-thunderbird )"
DEPEND="${RDEPEND}
		  sys-devel/gettext
		>=dev-util/pkgconfig-0.19
		>=dev-util/intltool-0.35"

DOCS="AUTHORS ChangeLog NEWS README"

pkg_setup() {
	G2CONF="${G2CONF} \
			$(use_enable bluetooth) \
			$(use_enable eds evolution) \
			$(use_enable gaim) \
			$(use_enable gajim) \
			$(use_enable sylpheed) \
			$(use_enable thunderbird)"
}

src_unpack() {
	unpack ${A}
	cd ${S}

	# Convert autodetection into hard options
	epatch ${FILESDIR}/${PN}-0.10-configure-options.patch

	# Add support for gaim 2.0
	if has_version '=net-im/gaim-2*' ; then
		epatch ${FILESDIR}/${PN}-0.8-gaim-2.0-plugin.patch
	fi

	# Fix thunderbird support
	epatch ${FILESDIR}/${PN}-0.8-thunderbird-binaries.patch

	# Oh the joys of autotools
	eautoreconf
}

pkg_postinst() {
	gnome2_pkg_postinst

	if use gaim ; then
		elog "To enable SendTo support in GAIM, you must enable the plugin in GAIM"
		elog "Check Tools -> Preferences -> Plugins in the GAIM menu."
	fi
}
