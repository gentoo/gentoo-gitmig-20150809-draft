# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/URI-Find/URI-Find-20100211.ebuild,v 1.1 2010/02/11 20:10:32 tove Exp $

EAPI=2

MODULE_AUTHOR=MSCHWERN
inherit perl-module

DESCRIPTION="Find URIs in plain text"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND="dev-perl/URI"
DEPEND=">=virtual/perl-Module-Build-0.30
	test? ( >=virtual/perl-Test-Simple-0.82
		${RDEPEND} )"

SRC_TEST=do
