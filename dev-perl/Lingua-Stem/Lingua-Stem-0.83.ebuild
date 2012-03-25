# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Stem/Lingua-Stem-0.83.ebuild,v 1.7 2012/03/25 16:25:07 armin76 Exp $

MODULE_AUTHOR=SNOWHARE
inherit perl-module

DESCRIPTION="Porter's stemming algorithm for 'generic' English"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc x86"
IUSE=""

SRC_TEST="do"

RDEPEND="dev-perl/Snowball-Norwegian
	dev-perl/Snowball-Swedish
	dev-perl/Lingua-Stem-Snowball-Da
	dev-perl/Lingua-Stem-Fr
	dev-perl/Lingua-Stem-It
	dev-perl/Lingua-Stem-Ru
	dev-perl/Lingua-PT-Stemmer
	dev-perl/Text-German
	dev-lang/perl"

DEPEND="virtual/perl-Module-Build
	${RDEPEND}"
