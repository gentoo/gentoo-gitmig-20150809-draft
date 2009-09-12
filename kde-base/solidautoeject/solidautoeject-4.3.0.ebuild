# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/solidautoeject/solidautoeject-4.3.0.ebuild,v 1.3 2009/09/12 10:36:14 armin76 Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="KDE4: Ejects optical drives when the eject button is pressed"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~x86"
IUSE="debug"

DEPEND="
	>=kde-base/solid-${PV}:${SLOT}[kdeprefix=]
"
RDEPEND="${DEPEND}"
