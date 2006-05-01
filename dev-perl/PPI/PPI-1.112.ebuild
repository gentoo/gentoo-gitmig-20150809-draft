# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PPI/PPI-1.112.ebuild,v 1.1 2006/05/01 21:54:15 mcummings Exp $

inherit perl-module

DESCRIPTION="Parse, Analyze and Manipulate Perl (without perl)"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/File-Remove
		dev-perl/Test-SubCalls
		dev-perl/Test-ClassAPI
		>=virtual/perl-Scalar-List-Utils-1.17
		>=dev-perl/Params-Util-0.05
		>=dev-perl/Clone-0.17
		dev-perl/List-MoreUtils"
