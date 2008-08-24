# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-SubCalls/Test-SubCalls-1.08.ebuild,v 1.1 2008/08/24 07:53:40 tove Exp $

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Track the number of times subs are called"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/Hook-LexWrap-0.20
	virtual/perl-File-Spec
	dev-lang/perl"
