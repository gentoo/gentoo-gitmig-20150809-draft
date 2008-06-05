# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgamma/kgamma-4.0.5.ebuild,v 1.1 2008/06/05 21:46:15 keytoaster Exp $

EAPI="1"

KMNAME=kdegraphics
inherit kde4-meta

DESCRIPTION="KDE screen gamma values kcontrol module"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="
	x11-apps/xgamma
	x11-libs/libXxf86vm
	x11-proto/xf86vidmodeproto"
RDEPEND="${DEPEND}"
