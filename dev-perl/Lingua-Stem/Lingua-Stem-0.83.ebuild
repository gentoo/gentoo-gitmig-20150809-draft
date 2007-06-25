# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Stem/Lingua-Stem-0.83.ebuild,v 1.1 2007/06/25 10:12:13 mcummings Exp $

inherit perl-module

DESCRIPTION="Porter's stemming algorithm for 'generic' English"
HOMEPAGE="http://search.cpan.org/~snowhare/"
SRC_URI="mirror://cpan/authors/id/S/SN/SNOWHARE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/module-build
	${DEPEND}"

RDEPEND="dev-perl/Snowball-Norwegian
	dev-perl/Snowball-Swedish
		dev-perl/Lingua-Stem-Snowball-Da
		dev-perl/Lingua-Stem-Fr
		dev-perl/Lingua-Stem-It
		dev-perl/Lingua-Stem-Ru
		dev-perl/Lingua-PT-Stemmer
		dev-perl/Text-German
	dev-lang/perl"
