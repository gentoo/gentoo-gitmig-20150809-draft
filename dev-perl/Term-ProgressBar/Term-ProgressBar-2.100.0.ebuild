# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Term-ProgressBar/Term-ProgressBar-2.100.0.ebuild,v 1.2 2011/12/30 04:05:30 jer Exp $

EAPI=4

MODULE_AUTHOR=SZABGAB
MODULE_VERSION=2.10
inherit perl-module

DESCRIPTION="Perl module for Term-ProgressBar"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~x86"
IUSE="test"

RDEPEND="
	dev-perl/Class-MethodMaker
	dev-perl/TermReadKey
"
DEPEND="${RDEPEND}
	test? (
		>=dev-perl/Test-Exception-0.310.0
		>=dev-perl/Capture-Tiny-0.130.0
	)
"

SRC_TEST="do"

src_test() {
	rm "${S}"/t/0-signature.t || die
	perl-module_src_test
}
