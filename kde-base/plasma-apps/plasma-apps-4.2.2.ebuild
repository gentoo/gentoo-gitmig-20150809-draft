# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/plasma-apps/plasma-apps-4.2.2.ebuild,v 1.1 2009/04/12 06:40:51 alexxy Exp $

EAPI="2"

KMNAME="kdebase-apps"
KMMODULE="plasma"
inherit kde4-meta

DESCRIPTION="Additional Applets for Plasma"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/libkonq-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}
	!kdeprefix? ( !kde-base/plasma[-kdeprefix] )
"
