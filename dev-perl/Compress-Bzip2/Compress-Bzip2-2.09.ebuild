# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Compress-Bzip2/Compress-Bzip2-2.09.ebuild,v 1.2 2005/11/22 13:34:40 mcummings Exp $

inherit perl-module

DESCRIPTION="A Bzip2 perl module"
HOMEPAGE="http://cpan.pair.com/modules/by-module/Compress/${P}.readme"
SRC_URI="mirror://cpan/modules/by-module/Compress/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="sparc x86"
IUSE=""

DEPEND="app-arch/bzip2"

SRC_TEST="do"

mydoc="TODO"
