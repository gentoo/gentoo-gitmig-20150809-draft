# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/soliduiserver/soliduiserver-4.0.5.ebuild,v 1.1 2008/06/05 22:46:08 keytoaster Exp $

EAPI="1"

KMNAME=kdebase-runtime
inherit kde4-meta

DESCRIPTION="KDE4: Soliduiserver"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/solid-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
