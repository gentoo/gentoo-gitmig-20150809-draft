# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Compress-Zlib/Compress-Zlib-1.35.ebuild,v 1.7 2005/07/28 22:40:29 matsuu Exp $

inherit perl-module

DESCRIPTION="A Zlib perl module"
HOMEPAGE="http://cpan.pair.com/modules/by-module/Compress/${P}.readme"
SRC_URI="mirror://cpan/modules/by-module/Compress/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm hppa ~ia64 ~m68k ~mips ppc ppc64 ~s390 sh sparc x86"
IUSE=""

DEPEND="sys-libs/zlib"

SRC_TEST="do"

mydoc="TODO"
