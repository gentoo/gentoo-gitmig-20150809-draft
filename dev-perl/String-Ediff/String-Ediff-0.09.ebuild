# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/String-Ediff/String-Ediff-0.09.ebuild,v 1.3 2007/07/10 23:33:27 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Produce common sub-string indices for two strings"
SRC_URI="mirror://cpan/authors/id/B/BO/BOXZOU/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~boxzou/String-Ediff-0.08/"
SRC_TEST="do"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"
