# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Clone/Clone-0.15.ebuild,v 1.8 2005/03/30 17:39:53 gustavoz Exp $

inherit perl-module

DESCRIPTION="Recursively copy Perl datatypes"
SRC_URI="mirror://cpan/modules/by-authors/id/R/RD/RDF/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RD/RDF/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~amd64 alpha ~hppa ~mips ~ppc sparc ~ppc64"
IUSE=""

SRC_TEST="do"

DEPEND=""
