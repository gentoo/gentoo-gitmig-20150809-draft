# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Astro-SunTime/Astro-SunTime-0.01.ebuild,v 1.11 2007/01/14 22:23:26 mcummings Exp $

inherit perl-module

DESCRIPTION="Provides a function interface to calculate sun rise/set times."
HOMEPAGE="http://search.cpan.org/~robf"
SRC_URI="mirror://cpan/authors/id/R/RO/ROBF/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ia64 ppc x86"
IUSE=""

SRC_TEST="do"
DEPEND="dev-perl/Time-modules
	dev-lang/perl"
