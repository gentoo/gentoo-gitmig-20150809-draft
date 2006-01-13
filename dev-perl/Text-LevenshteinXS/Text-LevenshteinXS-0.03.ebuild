# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-LevenshteinXS/Text-LevenshteinXS-0.03.ebuild,v 1.2 2006/01/13 17:52:48 mcummings Exp $

inherit perl-module

DESCRIPTION="An XS implementation of the Levenshtein edit distance"
HOMEPAGE="http://search.cpan.org/~jgoldberg/${P}/"
SRC_URI="mirror://cpan/authors/id/J/JG/JGOLDBERG/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~sparc x86"
IUSE=""

SRC_TEST="do"
