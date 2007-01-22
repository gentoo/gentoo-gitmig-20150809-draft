# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/terminal/terminal-0.2.6.ebuild,v 1.1 2007/01/22 02:13:46 nichoj Exp $

inherit gnome2 xfce44

xfce44

MY_P="${P/t/T}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="Terminal for Xfce4"
SRC_URI="http://www.xfce.org/archive/xfce-${XFCE_MASTER_VERSION}/src/${MY_P}${COMPRESS}"
HOMEPAGE="http://www.xfce.org"
LICENSE="LGPL-2"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"

IUSE="dbus startup-notification doc"

RDEPEND=">=dev-libs/glib-2
	>=x11-libs/gtk+-2.6
	media-libs/fontconfig
	media-libs/freetype
	media-libs/libpng
	dbus? ( || 	( >=dev-libs/dbus-glib-0.71
				( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.34 ) )
	)
	|| ( ( x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXrender )
	virtual/x11 )
	startup-notification? ( >=x11-libs/startup-notification-0.5 )
	>=x11-libs/vte-0.11.11
	doc? ( dev-libs/libxslt )
	>=xfce-extra/exo-0.3.2"

XFCE_CONFIG="$(use_enable startup-notification) $(use_enable dbus) \
	$(use_enable doc xsltproc)"

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
