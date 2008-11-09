# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kshisen/kshisen-4.1.3.ebuild,v 1.1 2008/11/09 00:46:24 scarabeus Exp $

EAPI="2"

KMNAME=kdegames
inherit kde4-meta

DESCRIPTION="A KDE game similiar to Mahjongg"
KEYWORDS="~amd64 ~x86"
IUSE="debug htmlhandbook"

DEPEND=">=kde-base/libkmahjongg-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
