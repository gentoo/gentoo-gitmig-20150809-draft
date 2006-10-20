# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Base/Test-Base-0.52.ebuild,v 1.4 2006/10/20 19:57:24 kloeri Exp $

inherit perl-module

DESCRIPTION="A Data Driven Testing Framework"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/I/IN/INGY/${P}.tar.gz"
LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND=">=virtual/perl-Test-Simple-0.62
		>=dev-perl/Spiffy-0.30
		>=dev-lang/perl-5.6.1"
