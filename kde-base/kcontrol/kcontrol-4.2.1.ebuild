# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kcontrol/kcontrol-4.2.1.ebuild,v 1.2 2009/03/08 13:26:11 scarabeus Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="The KDE Control Center"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"
IUSE="debug"

RDEPEND="
	!kdeprefix? ( !<kde-base/ksmserver-${PV} )
	kdeprefix? ( !<kde-base/ksmserver-${PV}:${SLOT} )
	>=kde-base/kdnssd-${PV}:${SLOT}[kdeprefix=]
	>=kde-base/khotkeys-${PV}:${SLOT}[kdeprefix=]
"
