# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Simple/Test-Simple-0.53.ebuild,v 1.1 2004/12/06 07:43:50 mcummings Exp $

inherit perl-module

DESCRIPTION="Basic utilities for writing tests"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mschwern/${P}/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa ~mips"

mydoc="rfc*.txt"
myconf="INSTALLDIRS=vendor"
DEPEND=">=dev-lang/perl-5.8.0-r12
		>=dev-perl/Test-Harness-2.03"

SRC_TEST="do"
