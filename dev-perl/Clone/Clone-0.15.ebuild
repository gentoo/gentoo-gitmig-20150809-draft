# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Clone/Clone-0.15.ebuild,v 1.5 2004/12/23 11:50:22 nigoro Exp $

inherit perl-module

DESCRIPTION="Recursively copy Perl datatypes"
SRC_URI="http://www.cpan.org/modules/by-authors/id/R/RD/RDF/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/R/RD/RDF/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~x86 ~amd64 ~alpha ~hppa ~mips ~ppc ~sparc ~ppc64"
IUSE=""

SRC_TEST="do"

DEPEND=""
