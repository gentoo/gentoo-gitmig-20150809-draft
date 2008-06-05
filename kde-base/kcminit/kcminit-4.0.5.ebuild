# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcminit/kcminit-4.0.5.ebuild,v 1.1 2008/06/05 21:13:37 keytoaster Exp $

EAPI="1"

KMNAME=kdebase-workspace
inherit kde4-meta

DESCRIPTION="KCMInit - runs startups initialization for Control Modules."
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=">=kde-base/ksplash-${PV}:${SLOT}"
RDEPEND="${DEPEND}"
