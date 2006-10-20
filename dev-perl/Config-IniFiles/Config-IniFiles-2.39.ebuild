# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Config-IniFiles/Config-IniFiles-2.39.ebuild,v 1.6 2006/10/20 18:59:04 kloeri Exp $

inherit perl-module

DESCRIPTION="A module for reading .ini-style configuration files"
HOMEPAGE="http://search.cpan.org/~gcarls/${P}/"
SRC_URI="mirror://cpan/authors/id/G/GC/GCARLS/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc sparc ~x86"
IUSE="test"
SRC_TEST="do"
DEPEND="test? ( virtual/perl-Test-Harness )
	dev-lang/perl"
RDEPEND="dev-lang/perl"
