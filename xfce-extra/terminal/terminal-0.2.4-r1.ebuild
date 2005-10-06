# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/xfce-extra/terminal/terminal-0.2.4-r1.ebuild,v 1.1 2005/10/06 07:40:33 bcowan Exp $

inherit xfce42

DESCRIPTION="Terminal with close ties to xfce"
HOMEPAGE="http://www.os-cillation.com/"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

IUSE="dbus"

RDEPEND="|| ( ( x11-libs/libX11
	x11-libs/libXrender
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libXft )
	virtual/x11 )
	>=x11-libs/gtk+-2.4
	>=xfce-extra/exo-0.3.0-r1
	dbus? ( sys-apps/dbus )
	>=x11-libs/vte-0.11.11
	>=xfce-base/libxfce4mcs-4.2.2-r1"

MY_P="${PN/t/T}-${PV/_/}"
bzipped
goodies
S=${WORKDIR}/${MY_P}


if ! use dbus; then
	XFCE_CONFIG="--disable-dbus"
fi