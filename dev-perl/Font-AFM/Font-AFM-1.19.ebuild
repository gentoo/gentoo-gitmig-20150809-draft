# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Font-AFM/Font-AFM-1.19.ebuild,v 1.13 2007/07/10 23:33:28 mr_bones_ Exp $

# this is a dependency for RT

inherit perl-module

DESCRIPTION="Parse Adobe Font Metric files"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~gaas/"

SRC_TEST="do"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

DEPEND="dev-lang/perl"
