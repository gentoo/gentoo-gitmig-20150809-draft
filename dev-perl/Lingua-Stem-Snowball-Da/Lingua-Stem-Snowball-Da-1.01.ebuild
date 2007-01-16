# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Stem-Snowball-Da/Lingua-Stem-Snowball-Da-1.01.ebuild,v 1.10 2007/01/16 01:18:03 mcummings Exp $

inherit perl-module

DESCRIPTION="Porters stemming algorithm for Denmark"
HOMEPAGE="http://search.cpan.org/~cine/"
SRC_URI="mirror://cpan/authors/id/C/CI/CINE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
