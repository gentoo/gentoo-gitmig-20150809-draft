# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Tests/Pod-Tests-0.18.ebuild,v 1.12 2006/03/22 20:47:30 chriswhite Exp $

inherit perl-module

DESCRIPTION="Extracts embedded tests and code examples from POD"
HOMEPAGE="http://search.cpan.org/search?module=Pod-Tests"
SRC_URI="mirror://cpan/authors/id/A/AD/ADAMK/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=virtual/perl-Test-Harness-1.22"
