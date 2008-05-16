# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/soliduiserver/soliduiserver-4.0.4.ebuild,v 1.1 2008/05/16 00:57:05 ingmar Exp $

EAPI="1"

KMNAME=kdebase-runtime
inherit kde4-meta

DESCRIPTION="KDE4: Soliduiserver"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/solid-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
