# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kstyles/kstyles-4.9.2.ebuild,v 1.2 2012/10/17 18:27:09 maekke Exp $

EAPI=4

KMNAME="kde-workspace"
inherit kde4-meta

DESCRIPTION="KDE: A set of different KDE styles."
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="
	$(add_kdebase_dep liboxygenstyle)
"
RDEPEND="${DEPEND}"

KMEXTRACTONLY="
	libs/oxygen
"
