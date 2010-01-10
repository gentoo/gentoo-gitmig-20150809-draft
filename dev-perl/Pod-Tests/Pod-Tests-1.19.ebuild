# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Pod-Tests/Pod-Tests-1.19.ebuild,v 1.2 2010/01/10 19:43:17 grobian Exp $

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Extracts embedded tests and code examples from POD"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

DEPEND="virtual/perl-File-Spec
	dev-lang/perl"

SRC_TEST="do"
