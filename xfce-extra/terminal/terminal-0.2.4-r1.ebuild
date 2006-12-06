# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/terminal/terminal-0.2.4-r1.ebuild,v 1.4 2006/12/06 05:51:45 nichoj Exp $

inherit xfce42

DESCRIPTION="Terminal with close ties to xfce"
HOMEPAGE="http://www.os-cillation.com/"
KEYWORDS="~amd64 ~arm ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="dbus"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libXrender
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXft )
	virtual/x11 )
	>=x11-libs/gtk+-2.4
	>=xfce-extra/exo-0.3.0-r1
	dbus? ( || 	( >=dev-libs/dbus-glib-0.71
				( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.34 ) )
	)
	>=x11-libs/vte-0.11.11
	x11-libs/startup-notification
	>=xfce-base/libxfce4mcs-4.2.2-r1"

MY_P="${PN/t/T}-${PV/_/}"
bzipped
goodies
S=${WORKDIR}/${MY_P}


if ! use dbus; then
	XFCE_CONFIG="--disable-dbus"
fi
