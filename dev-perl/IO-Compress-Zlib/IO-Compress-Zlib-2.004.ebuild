# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Compress-Zlib/IO-Compress-Zlib-2.004.ebuild,v 1.9 2007/07/05 14:32:23 armin76 Exp $

inherit perl-module

DESCRIPTION="Read/Write compressed files"
HOMEPAGE="http://search.cpan.org/~pqms"
SRC_URI="mirror://cpan/authors/id/P/PM/PMQS/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 m68k mips ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-perl/IO-Compress-Base-2.004
	dev-perl/Compress-Raw-Zlib
	dev-lang/perl"

SRC_TEST="do"
