# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/ktrafficanalyzer/ktrafficanalyzer-0.5.3.ebuild,v 1.2 2010/06/03 17:11:35 spatz Exp $

EAPI=2
inherit kde4-base

MY_P=KTrafficAnalyzer-${PV}

DESCRIPTION="A network traffic visualizer"
HOMEPAGE="http://ktrafficanalyze.sourceforge.net/"
SRC_URI="mirror://sourceforge/ktrafficanalyze/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

S=${WORKDIR}/${MY_P}

PATCHES=(
	"${FILESDIR}/${P}-gcc45.patch"
)

DOCS="CHANGELOG SSHUsage TODO"
