# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Compress-Zlib/Compress-Zlib-1.33.ebuild,v 1.6 2004/12/22 11:57:49 nigoro Exp $

inherit perl-module

DESCRIPTION="A Zlib perl module"
HOMEPAGE="http://cpan.pair.com/modules/by-module/Compress/${P}.readme"
SRC_URI="http://cpan.pair.com/modules/by-module/Compress/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~x86 ppc ~sparc ~alpha ~mips ~hppa ~amd64 ~ppc64"
IUSE=""

SRC_TEST="do"

DEPEND="sys-libs/zlib"

mydoc="TODO"
