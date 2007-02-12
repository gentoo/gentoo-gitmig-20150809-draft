# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/pkgcore-checks/pkgcore-checks-0.3.ebuild,v 1.1 2007/02/12 11:16:28 masterdriverz Exp $

inherit distutils eutils

DESCRIPTION="pkgcore developmental repoman replacement"
HOMEPAGE="http://www.pkgcore.org/"
SRC_URI="http://www.pkgcore.org/releases/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE=""

RDEPEND=">=sys-apps/pkgcore-0.2.3
	>=dev-lang/python-2.4"
DEPEND=">=dev-lang/python-2.4"

src_test() {
	cd "${S}"
	"${python}" setup.py test || die "tests returned non zero"
}

pkg_postinst() {
	einfo "updating pkgcore plugin cache"
	pplugincache pkgcore_checks.plugins
}
