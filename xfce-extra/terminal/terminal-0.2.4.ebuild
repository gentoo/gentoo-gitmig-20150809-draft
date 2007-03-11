# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/terminal/terminal-0.2.4.ebuild,v 1.10 2007/03/11 10:34:11 drac Exp $

inherit xfce42

DESCRIPTION="Terminal"
HOMEPAGE="http://www.os-cillation.com/"
KEYWORDS="~amd64 arm ia64 ppc ppc64 ~sparc x86"
IUSE="dbus"

RDEPEND="x11-libs/libX11
	x11-libs/libXrender
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXft
	>=x11-libs/gtk+-2.4
	=xfce-extra/exo-0.3*
	dbus? ( || 	( >=dev-libs/dbus-glib-0.71
				( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.34 ) )
	)
	>=x11-libs/vte-0.11.11
	x11-libs/startup-notification
	=xfce-base/libxfce4mcs-4.2*"

MY_P="${PN/t/T}-${PV/_/}"
bzipped
goodies
S=${WORKDIR}/${MY_P}


if ! use dbus; then
	XFCE_CONFIG="--disable-dbus"
fi
