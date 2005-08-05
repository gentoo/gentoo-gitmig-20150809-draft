# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Stem/Lingua-Stem-0.81.ebuild,v 1.4 2005/08/05 16:27:25 dholm Exp $

inherit perl-module

DESCRIPTION="Porter's stemming algorithm for 'generic' English"
HOMEPAGE="http://search.cpan.org/~snowhare/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SN/SNOWHARE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Snowball-Norwegian
		dev-perl/Snowball-Swedish
		dev-perl/Lingua-Stem-Snowball-Da
		dev-perl/Lingua-Stem-Fr
		dev-perl/Lingua-Stem-It
		dev-perl/Lingua-Stem-Ru
		dev-perl/Lingua-PT-Stemmer
		dev-perl/Text-German"
