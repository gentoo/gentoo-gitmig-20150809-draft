# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Inline-Python/Inline-Python-0.28.ebuild,v 1.3 2009/05/02 22:55:45 gentoofan23 Exp $

MODULE_AUTHOR=NINE
inherit perl-module

DESCRIPTION="Easy implementation of Python extensions"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND=">=dev-perl/Inline-0.42
	dev-lang/python
	dev-lang/perl"
