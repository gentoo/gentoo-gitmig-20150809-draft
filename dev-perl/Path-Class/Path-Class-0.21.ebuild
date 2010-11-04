# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Path-Class/Path-Class-0.21.ebuild,v 1.2 2010/11/04 13:33:29 fauli Exp $

EAPI=3

MODULE_AUTHOR=KWILLIAMS
inherit perl-module

DESCRIPTION="Cross-platform path specification manipulation"

SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~ppc64 ~sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="test"

RDEPEND=">=virtual/perl-File-Spec-0.87"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( virtual/perl-Test-Simple )"

SRC_TEST="do"
