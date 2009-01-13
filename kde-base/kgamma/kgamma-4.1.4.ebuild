# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgamma/kgamma-4.1.4.ebuild,v 1.1 2009/01/13 22:00:25 alexxy Exp $

EAPI="2"

KMNAME=kdegraphics
inherit kde4-meta

DESCRIPTION="KDE screen gamma values kcontrol module"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug htmlhandbook"

DEPEND="x11-apps/xgamma
	x11-libs/libXxf86vm
	x11-proto/xf86vidmodeproto"
RDEPEND="${DEPEND}"
