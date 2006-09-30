# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgcore-checks/pkgcore-checks-0.1.ebuild,v 1.1 2006/09/30 22:25:48 marienz Exp $

inherit distutils

DESCRIPTION="pkgcore developmental repoman replacement"
HOMEPAGE="http://dev.gentooexperimental.org/pkgcore-trac/"
SRC_URI="http://dev.gentooexperimental.org/~pkgcore/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND="~sys-apps/pkgcore-${PV}
	>=dev-lang/python-2.4"
DEPEND=">=dev-lang/python-2.4"
