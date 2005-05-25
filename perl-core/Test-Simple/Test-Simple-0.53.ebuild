# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Test-Simple/Test-Simple-0.53.ebuild,v 1.1 2005/05/25 14:54:32 mcummings Exp $

inherit perl-module

DESCRIPTION="Basic utilities for writing tests"
HOMEPAGE="http://search.cpan.org/~mschwern/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ia64 ~mips ~ppc ppc64 ~s390 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.0-r12
	>=perl-core/Test-Harness-2.03"

mydoc="rfc*.txt"
myconf="INSTALLDIRS=vendor"
SRC_TEST="do"
