# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Levenshtein/Text-Levenshtein-0.05.ebuild,v 1.1 2004/07/30 16:00:22 mcummings Exp $

inherit perl-module

DESCRIPTION="An implementation of the Levenshtein edit distance"
HOMEPAGE="http://search.cpan.org/~jgoldberg/${P}/"
SRC_URI="http://www.cpan.org/authors/id/J/JG/JGOLDBERG/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

SRC_TEST="do"
