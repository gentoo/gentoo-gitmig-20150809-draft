# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/qalculate-applet/qalculate-applet-0.7.2.ebuild,v 1.3 2010/04/18 14:16:38 nixnut Exp $

EAPI=2
inherit kde4-base

MY_P=${PN/-/_}-${PV}

DESCRIPTION="Qalculate! Plasmoid"
HOMEPAGE="http://wwwu.uni-klu.ac.at/magostin/qalculate.html"
SRC_URI="http://wwwu.uni-klu.ac.at/magostin/src/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ppc ~x86"
IUSE="debug"

DEPEND=">=kde-base/plasma-workspace-${KDE_MINIMAL}
	>=sci-libs/libqalculate-0.9.6-r1"

S=${WORKDIR}/${MY_P}

DOCS="Changelog README TODO"
