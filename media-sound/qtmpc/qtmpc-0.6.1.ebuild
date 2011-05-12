# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/qtmpc/qtmpc-0.6.1.ebuild,v 1.1 2011/05/12 13:07:20 scarabeus Exp $

EAPI=4

MY_P="QtMPC-${PV}"
inherit kde4-base

DESCRIPTION="Qt MPD client with a tree view music library interface"
HOMEPAGE="http://lowblog.nl/category/qtmpc/"
SRC_URI="http://files.lowblog.nl/${PN}/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/QtMPC"
