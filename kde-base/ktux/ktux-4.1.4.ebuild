# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/ktux/ktux-4.1.4.ebuild,v 1.1 2009/01/13 23:04:25 alexxy Exp $

EAPI="2"

KMNAME=kdetoys
inherit kde4-meta

DESCRIPTION="KDE: screensaver featuring the Space-Faring Tux"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

DEPEND=">=app-misc/strigi-0.5.7
	>=kde-base/kscreensaver-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
