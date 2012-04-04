# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/krfb/krfb-4.8.1.ebuild,v 1.2 2012/04/04 18:42:16 ago Exp $

EAPI=4

KDE_HANDBOOK="optional"
KMNAME="kdenetwork"
inherit kde4-meta

DESCRIPTION="VNC-compatible server to share KDE desktops"
KEYWORDS="amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	sys-libs/zlib
	virtual/jpeg
	!aqua? ( x11-libs/libXdamage )
"
RDEPEND="${DEPEND}"
