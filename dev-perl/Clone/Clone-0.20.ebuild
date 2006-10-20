# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Clone/Clone-0.20.ebuild,v 1.8 2006/10/20 18:58:02 kloeri Exp $

inherit perl-module

DESCRIPTION="Recursively copy Perl datatypes"
SRC_URI="mirror://cpan/modules/by-authors/id/R/RD/RDF/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RD/RDF/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc ~ppc64 sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
