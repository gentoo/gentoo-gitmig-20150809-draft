# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Parse-RecDescent/Parse-RecDescent-1.965.001.ebuild,v 1.4 2010/06/27 19:18:06 nixnut Exp $

EAPI=2

inherit versionator
MY_P=${PN}-$(delete_version_separator 2 )
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=DCONWAY
inherit perl-module

DESCRIPTION="Parse::RecDescent - generate recursive-descent parsers"

SLOT="0"
KEYWORDS="alpha amd64 arm ~hppa ia64 ~mips ppc ~ppc64 s390 sh sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE="test"

RDEPEND="virtual/perl-Text-Balanced
	virtual/perl-version"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"

src_install() {
	perl-module_src_install
	dohtml -r tutorial || die
}
