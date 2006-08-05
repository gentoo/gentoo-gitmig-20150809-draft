# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/String-Ediff/String-Ediff-0.03.ebuild,v 1.4 2006/08/05 23:04:46 mcummings Exp $

inherit perl-module

DESCRIPTION="Produce common sub-string indices for two strings"
SRC_URI="mirror://cpan/authors/id/B/BO/BOXSOU/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~boxzou/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
