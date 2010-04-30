# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Stem/Lingua-Stem-0.84.ebuild,v 1.1 2010/04/30 07:13:32 tove Exp $

EAPI=3

MODULE_AUTHOR=SNOWHARE
inherit perl-module

DESCRIPTION="Porter's stemming algorithm for 'generic' English"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~sparc ~x86"
IUSE=""

RDEPEND="dev-perl/Snowball-Norwegian
	dev-perl/Snowball-Swedish
	dev-perl/Lingua-Stem-Snowball-Da
	dev-perl/Lingua-Stem-Fr
	dev-perl/Lingua-Stem-It
	dev-perl/Lingua-Stem-Ru
	dev-perl/Lingua-PT-Stemmer
	dev-perl/Text-German"
DEPEND="virtual/perl-Module-Build
	${RDEPEND}"

SRC_TEST="do"
