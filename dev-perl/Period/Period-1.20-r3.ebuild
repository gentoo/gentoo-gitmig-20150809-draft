# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Period/Period-1.20-r3.ebuild,v 1.16 2012/02/12 18:12:13 armin76 Exp $

inherit perl-module

DESCRIPTION="time period Perl module"
SRC_URI="mirror://cpan/authors/id/P/PR/PRYAN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~pryan/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ppc x86"
IUSE=""

DEPEND="dev-lang/perl"
