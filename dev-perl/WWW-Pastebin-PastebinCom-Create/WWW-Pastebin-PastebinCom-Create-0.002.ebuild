# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/WWW-Pastebin-PastebinCom-Create/WWW-Pastebin-PastebinCom-Create-0.002.ebuild,v 1.3 2009/07/14 18:58:44 tove Exp $

EAPI=2

MODULE_AUTHOR=ZOFFIX
inherit perl-module

DESCRIPTION="paste to <http://pastebin.com> from Perl"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

COMMON_DEPEND="
	>=dev-perl/URI-1.35
	>=dev-perl/libwww-perl-5.807
"
DEPEND="
	${COMMON_DEPEND}
	virtual/perl-Module-Build
	test? (
		virtual/perl-Test-Simple
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage
	)
"
RDEPEND="
	${COMMON_DEPEND}
"
SRC_TEST="do"
