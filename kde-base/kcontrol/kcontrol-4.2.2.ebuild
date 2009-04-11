# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-4.2.2.ebuild,v 1.1 2009/04/11 22:19:36 alexxy Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Control Center"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~x86"
IUSE="debug doc"

RDEPEND="
	!kdeprefix? ( !kde-base/ksmserver:4.1[-kdeprefix] )
	>=kde-base/kdnssd-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/khotkeys-${PV}:${SLOT}[kdeprefix=]
"
