# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/weblint/weblint-1.020.ebuild,v 1.10 2004/06/25 02:50:15 agriffis Exp $

DESCRIPTION="syntax and minimal style checker for HTML by Neil Bowers"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.w3.org/Tools/weblint.html"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ~ppc ~sparc alpha ~amd64"

DEPEND=""
RDEPEND="dev-lang/perl"

src_install() {
	dobin weblint
	doman weblint.1

	insinto /etc
	doins weblintrc
}
