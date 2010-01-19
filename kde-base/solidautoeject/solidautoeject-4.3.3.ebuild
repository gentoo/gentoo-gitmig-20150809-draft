# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/solidautoeject/solidautoeject-4.3.3.ebuild,v 1.7 2010/01/19 01:34:56 jer Exp $

EAPI="2"

KMNAME="kdebase-runtime"
inherit kde4-meta

DESCRIPTION="KDE4: Ejects optical drives when the eject button is pressed"
KEYWORDS="~alpha amd64 hppa ~ia64 ppc ppc64 ~sparc x86"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep solid)
"
RDEPEND="${DEPEND}"
