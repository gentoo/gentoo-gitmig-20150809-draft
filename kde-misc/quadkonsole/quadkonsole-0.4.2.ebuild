# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/quadkonsole/quadkonsole-0.4.2.ebuild,v 1.1 2011/09/24 15:56:55 dilfridge Exp $

EAPI=4

KDE_HANDBOOK=optional
inherit kde4-base

MY_P=${PN}4-${PV}

DESCRIPTION="Grid of Konsole terminals"
HOMEPAGE="http://kb.ccchl.de/quadkonsole4/"
SRC_URI="http://kb.ccchl.de/${PN}4/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

RDEPEND="
	$(add_kdebase_dep konsole)
	$(add_kdebase_dep libkonq)
"
DEPEND="${RDEPEND}"

DOCS=( AUTHORS ChangeLog )

S=${WORKDIR}/${MY_P}
