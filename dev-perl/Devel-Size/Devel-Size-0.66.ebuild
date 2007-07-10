# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Size/Devel-Size-0.66.ebuild,v 1.4 2007/07/10 23:33:30 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Perl extension for finding the memory usage of Perl variables"
HOMEPAGE="http://search.cpan.org/~tels/"
SRC_URI="mirror://cpan/authors/id/T/TE/TELS/devel/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ia64 sparc x86"
IUSE=""
PREFER_BUILDPL="no"

SRC_TEST="do"

DEPEND="dev-lang/perl"
