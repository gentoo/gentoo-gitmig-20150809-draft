# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Levenshtein/Text-Levenshtein-0.04.ebuild,v 1.2 2004/06/25 01:05:19 agriffis Exp $

inherit perl-module

MY_P=TL-${PV}
DESCRIPTION="An implementation of the Levenshtein edit distance"
HOMEPAGE="http://search.cpan.org/~jgoldberg/${MY_P}/"
SRC_URI="http://www.cpan.org/authors/id/J/JG/JGOLDBERG/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

SRC_TEST="do"
