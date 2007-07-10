# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Period/Period-1.20-r3.ebuild,v 1.15 2007/07/10 23:33:26 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="time period Perl module"
SRC_URI="mirror://cpan/authors/id/P/PR/PRYAN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~pryan/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
