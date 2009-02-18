# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/lcov/lcov-1.7.ebuild,v 1.1 2009/02/18 21:32:39 cardoe Exp $

DESCRIPTION="A graphical front-end for GCC's coverage testing tool gcov"
HOMEPAGE="http://ltp.sourceforge.net/coverage/lcov.php"
SRC_URI="mirror://sourceforge/ltp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=dev-lang/perl-5"

src_install() {
	emake PREFIX="${D}" install || die "install failed"
}
