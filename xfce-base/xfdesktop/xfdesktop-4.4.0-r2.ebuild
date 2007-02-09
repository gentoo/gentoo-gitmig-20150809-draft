# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-base/xfdesktop/xfdesktop-4.4.0-r2.ebuild,v 1.1 2007/02/09 15:29:43 drac Exp $

inherit xfce44

xfce44

DESCRIPTION="Desktop manager"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE="dbus debug doc minimal plugins"

RDEPEND="x11-libs/libX11
	x11-libs/libSM
	>=dev-libs/glib-2.6
	>=x11-libs/gtk+-2.6
	gnome-base/librsvg
	>=xfce-base/libxfce4mcs-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfce4util-${XFCE_MASTER_VERSION}
	>=xfce-base/libxfcegui4-${XFCE_MASTER_VERSION}
	plugins? ( >=xfce-base/xfce4-panel-${XFCE_MASTER_VERSION} )
	>=xfce-base/xfce-mcs-manager-${XFCE_MASTER_VERSION}
	dbus? ( || ( dev-libs/dbus-glib <sys-apps/dbus-1 )
		>=xfce-base/thunar-${THUNAR_MASTER_VERSION} )
	!minimal? ( >=xfce-extra/exo-0.3.2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	dev-util/intltool"

XFCE_CONFIG="${XFCE_CONFIG} $(use_enable plugins panel-plugin) \
	$(use_enable doc xsltproc) --enable-desktop-icons"

pkg_setup() {
	if use dbus; then
		XFCE_CONFIG="${XFCE_CONFIG} --enable-thunarx --enable-file-icons"
	else
		XFCE_CONFIG="${XFCE_CONFIG} --disable-thunarx --disable-file-icons"
	fi

	if use minimal; then
		XFCE_CONFIG="${XFCE_CONFIG} --disable-exo"
	else
		XFCE_CONFIG="${XFCE_CONFIG} --enable-exo"
	fi
}

DOCS="AUTHORS ChangeLog NEWS TODO README"

xfce44_core_package
