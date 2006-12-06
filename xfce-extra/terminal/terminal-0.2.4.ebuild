# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/terminal/terminal-0.2.4.ebuild,v 1.9 2006/12/06 05:51:45 nichoj Exp $

DESCRIPTION="Terminal with close ties to xfce"
HOMEPAGE="http://www.os-cillation.com/"
KEYWORDS="~amd64 arm ia64 ppc ppc64 ~sparc x86"

IUSE="dbus"

RDEPEND=">=x11-libs/gtk+-2.4
	>=xfce-extra/exo-0.3.0_pre1
	dbus? ( || 	( >=dev-libs/dbus-glib-0.71
				( <sys-apps/dbus-0.90 >=sys-apps/dbus-0.34 ) )
	)
	>=x11-libs/vte-0.11.11
	>=xfce-base/libxfce4mcs-4.2.0"

MY_P="${PN/t/T}-${PV/_/}"
BZIPPED=1
GOODIES=1

if ! use dbus; then
	XFCE_CONFIG="--disable-dbus"
fi

inherit xfce4
