# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/kprayertime/kprayertime-4.01.ebuild,v 1.2 2011/01/31 05:58:17 tampakrap Exp $

EAPI=3
inherit kde4-base

DESCRIPTION="Islamic Prayer Times Plasmoid"
HOMEPAGE="http://kprayertime.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P/-}.src.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DOCS="README"

S="${WORKDIR}/src"
