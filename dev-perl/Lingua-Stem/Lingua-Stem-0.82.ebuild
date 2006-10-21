# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Stem/Lingua-Stem-0.82.ebuild,v 1.3 2006/10/21 00:24:30 mcummings Exp $

inherit perl-module

DESCRIPTION="Porter's stemming algorithm for 'generic' English"
HOMEPAGE="http://search.cpan.org/~snowhare/${P}/"
SRC_URI="mirror://cpan/authors/id/S/SN/SNOWHARE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Snowball-Norwegian
	dev-perl/Snowball-Swedish
		dev-perl/Lingua-Stem-Snowball-Da
		dev-perl/Lingua-Stem-Fr
		dev-perl/Lingua-Stem-It
		dev-perl/Lingua-Stem-Ru
		dev-perl/Lingua-PT-Stemmer
		dev-perl/Text-German
	dev-lang/perl"
RDEPEND="${DEPEND}"

