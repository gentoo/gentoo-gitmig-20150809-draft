# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Compress-Zlib/IO-Compress-Zlib-2.001.ebuild,v 1.2 2006/11/07 05:41:43 tsunam Exp $

inherit perl-module


DESCRIPTION="Read/Write compressed files"
HOMEPAGE="http://search.cpan.org/~pqms"
SRC_URI="mirror://cpan/authors/id/P/PM/PMQS/${P}.tar.gz"


IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~mips ~sparc x86"
SRC_TEST="do"

DEPEND="dev-perl/IO-Compress-Base
	dev-perl/Compress-Raw-Zlib
	dev-lang/perl"
