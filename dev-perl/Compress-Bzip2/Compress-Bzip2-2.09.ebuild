# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Compress-Bzip2/Compress-Bzip2-2.09.ebuild,v 1.5 2006/04/20 19:25:59 tcort Exp $

inherit perl-module

DESCRIPTION="A Bzip2 perl module"
HOMEPAGE="http://cpan.pair.com/modules/by-module/Compress/${P}.readme"
SRC_URI="mirror://cpan/modules/by-module/Compress/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~mips sparc x86"
IUSE=""

DEPEND="app-arch/bzip2"

SRC_TEST="do"

mydoc="TODO"
