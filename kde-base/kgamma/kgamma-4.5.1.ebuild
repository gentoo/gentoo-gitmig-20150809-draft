# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kgamma/kgamma-4.5.1.ebuild,v 1.1 2010/09/06 00:30:23 tampakrap Exp $

EAPI="3"

KDE_HANDBOOK=1
KMNAME="kdegraphics"
inherit kde4-meta

DESCRIPTION="KDE screen gamma values kcontrol module"
KEYWORDS=""
IUSE="debug"

RDEPEND="
	x11-libs/libXxf86vm
"
DEPEND="${RDEPEND}
	x11-proto/xf86vidmodeproto
"

src_unpack() {
	if use handbook; then
		KMEXTRA+=" doc/kcontrol/kgamma"
	fi

	kde4-meta_src_unpack
}
