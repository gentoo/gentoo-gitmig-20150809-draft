# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/weblint/weblint-1.020.ebuild,v 1.12 2005/08/07 13:06:00 hansmi Exp $

DESCRIPTION="syntax and minimal style checker for HTML by Neil Bowers"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.w3.org/Tools/weblint.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="alpha ~amd64 ppc ~sparc x86"
IUSE=""

DEPEND=""
RDEPEND="dev-lang/perl"

src_install() {
	dobin weblint
	doman weblint.1

	insinto /etc
	doins weblintrc
}
