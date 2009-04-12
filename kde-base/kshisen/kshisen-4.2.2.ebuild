# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kshisen/kshisen-4.2.2.ebuild,v 1.1 2009/04/12 05:59:41 alexxy Exp $

EAPI="2"

KMNAME="kdegames"
inherit kde4-meta

DESCRIPTION="A KDE game similiar to Mahjongg"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug doc"

DEPEND="
	>=kde-base/libkmahjongg-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"
