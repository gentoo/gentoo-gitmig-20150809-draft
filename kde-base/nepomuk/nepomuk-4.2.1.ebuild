# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/nepomuk/nepomuk-4.2.1.ebuild,v 1.1 2009/03/04 22:48:46 alexxy Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="Nepomuk KDE4 client"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	dev-libs/soprano[clucene]
	>=kde-base/kdelibs-${PV}:${SLOT}[semantic-desktop]
"
RDEPEND="${DEPEND}"
