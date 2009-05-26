# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-misc/bilbo/bilbo-0.9.ebuild,v 1.1 2009/05/26 22:10:12 dagger Exp $

EAPI="2"

inherit kde4-base

DESCRIPTION="A powerful KDE blogging client"
HOMEPAGE="http://bilbo.gnufolks.org/"
SRC_URI="ftp://download.ospdev.net/bilbo/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=kde-base/kdepimlibs-${KDE_MINIMAL}"
RDEPEND="${DEPEND}"
