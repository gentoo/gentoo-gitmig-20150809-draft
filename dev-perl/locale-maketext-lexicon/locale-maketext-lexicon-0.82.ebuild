# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/locale-maketext-lexicon/locale-maketext-lexicon-0.82.ebuild,v 1.3 2010/06/21 20:28:00 armin76 Exp $

EAPI=2

MODULE_AUTHOR=DRTECH
MY_PN=Locale-Maketext-Lexicon
MY_P=${MY_PN}-${PV}
S=${WORKDIR}/${MY_P}
inherit perl-module

DESCRIPTION="Use other catalog formats in Maketext"

LICENSE="MIT"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ~ppc sparc x86"
IUSE="test"

RDEPEND="virtual/perl-locale-maketext
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
