# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Getopt-Long/Getopt-Long-2.36.ebuild,v 1.10 2009/12/16 21:50:03 abcd Exp $

inherit perl-module

DESCRIPTION="Advanced handling of command line options"
SRC_URI="mirror://cpan/authors/id/J/JV/JV/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/J/JV/JV/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~arm hppa ia64 mips ppc ppc64 ~s390 ~sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

DEPEND="virtual/perl-PodParser
		dev-lang/perl"
