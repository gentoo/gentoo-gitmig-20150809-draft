# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-Inspector/Class-Inspector-1.06.ebuild,v 1.6 2005/01/21 23:25:31 kloeri Exp $

inherit perl-module

DESCRIPTION="Provides information about Classes"
HOMEPAGE="http://search.cpan.org/author/ADAMK/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 ~ppc sparc alpha ~hppa ~amd64 ~mips"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Test-Simple
	dev-perl/Class-ISA"
