# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Stem/Lingua-Stem-0.83.ebuild,v 1.6 2008/11/18 15:11:52 tove Exp $

MODULE_AUTHOR=SNOWHARE
inherit perl-module

DESCRIPTION="Porter's stemming algorithm for 'generic' English"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc sparc x86"
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
