# Copyright 2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/weblint/weblint-1.020.ebuild,v 1.3 2002/12/15 10:44:19 bjb Exp $

DESCRIPTION="Weblint is a syntax and minimal style checker for HTML by Neil Bowers"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.w3.org/Tools/weblint.html"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha"
IUSE=""
DEPEND=""
RDEPEND="sys-devel/perl"

src_install () {

	dobin weblint
	doman weblint.1

	insinto etc
	doins weblintrc
}
