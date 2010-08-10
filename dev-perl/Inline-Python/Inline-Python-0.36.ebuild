# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Inline-Python/Inline-Python-0.36.ebuild,v 1.1 2010/08/10 15:33:45 robbat2 Exp $

EAPI=2

MODULE_AUTHOR=NINE
inherit perl-module

DESCRIPTION="Easy implementation of Python extensions"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/Inline-0.42
	dev-lang/python"
RDEPEND="${DEPEND}"

SRC_TEST="do"
