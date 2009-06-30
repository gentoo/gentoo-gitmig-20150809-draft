# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/URI-Find/URI-Find-20090319.ebuild,v 1.1 2009/06/30 14:06:29 tove Exp $

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
