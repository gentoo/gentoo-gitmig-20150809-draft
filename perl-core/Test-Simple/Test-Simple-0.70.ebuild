# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Test-Simple/Test-Simple-0.70.ebuild,v 1.5 2007/08/12 20:27:06 tgall Exp $

inherit perl-module

DESCRIPTION="Basic utilities for writing tests"
HOMEPAGE="http://search.cpan.org/~mschwern/${P}/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSCHWERN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha ~amd64 ~arm ~hppa ia64 ~m68k ~mips ppc ppc64 ~s390 ~sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-lang/perl-5.8.0-r12"

SRC_TEST="do"

mydoc="rfc*.txt"
myconf="INSTALLDIRS=vendor"
