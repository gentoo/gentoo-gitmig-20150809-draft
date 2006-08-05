# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Heap/Heap-0.71.ebuild,v 1.14 2006/08/05 04:39:23 mcummings Exp $

inherit perl-module

DESCRIPTION="Heap - Perl extensions for keeping data partially sorted."
SRC_URI="mirror://cpan/authors/id/J/JM/JMM/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Heap/${P}.readme"

IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
