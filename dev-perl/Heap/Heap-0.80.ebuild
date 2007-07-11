# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Heap/Heap-0.80.ebuild,v 1.6 2007/07/11 15:17:57 armin76 Exp $

inherit perl-module

DESCRIPTION="Heap - Perl extensions for keeping data partially sorted."
SRC_URI="mirror://cpan/authors/id/J/JM/JMM/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~jmm/"

IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ~ppc ppc64 sparc x86"

DEPEND="dev-lang/perl"
