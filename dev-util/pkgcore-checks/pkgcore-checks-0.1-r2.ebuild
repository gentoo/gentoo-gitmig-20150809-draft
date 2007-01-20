# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgcore-checks/pkgcore-checks-0.1-r2.ebuild,v 1.2 2007/01/20 12:06:33 corsair Exp $

inherit distutils eutils

DESCRIPTION="pkgcore developmental repoman replacement"
HOMEPAGE="http://dev.gentooexperimental.org/pkgcore-trac/"
SRC_URI="http://dev.gentooexperimental.org/~pkgcore/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~x86"
IUSE=""

RDEPEND="=sys-apps/pkgcore-0.1*
	>=dev-lang/python-2.4"
DEPEND=">=dev-lang/python-2.4"


src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${P}-missing-glsa-dir.patch"
	epatch "${FILESDIR}/${P}-optimization.patch"
}
