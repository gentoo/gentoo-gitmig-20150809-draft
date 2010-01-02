# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ProgressBar/Term-ProgressBar-2.09.ebuild,v 1.16 2010/01/02 14:46:11 tove Exp $

MODULE_AUTHOR=FLUFFY
inherit perl-module

DESCRIPTION="Perl module for Term-ProgressBar"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

RDEPEND="dev-perl/Class-MethodMaker
	dev-perl/TermReadKey
	dev-lang/perl"
DEPEND="${RDEPEND}
		>=virtual/perl-Module-Build-0.28"

src_test() {
	rm "${S}"/t/0-signature.t || die
	perl-module_src_test
}
