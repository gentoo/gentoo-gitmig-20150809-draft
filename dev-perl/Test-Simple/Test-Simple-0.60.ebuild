# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Simple/Test-Simple-0.60.ebuild,v 1.2 2005/05/25 14:53:18 mcummings Exp $

inherit perl-module

DESCRIPTION="Basic utilities for writing tests"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mschwern/${P}/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~mips ~ppc64 ~arm ~ia64  ~s390"

mydoc="rfc*.txt"
myconf="INSTALLDIRS=vendor"
DEPEND=">=dev-lang/perl-5.8.0-r12
		>=perl-core/Test-Harness-2.03"

SRC_TEST="do"
