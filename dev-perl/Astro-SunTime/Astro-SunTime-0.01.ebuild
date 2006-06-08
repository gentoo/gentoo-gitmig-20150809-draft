# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Astro-SunTime/Astro-SunTime-0.01.ebuild,v 1.5 2006/06/08 21:04:23 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Provides a function interface to calculate sun rise/set times."
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/R/RO/ROBF/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ia64 ppc x86"
IUSE=""

SRC_TEST="do"
DEPEND="dev-perl/Time-modules"
