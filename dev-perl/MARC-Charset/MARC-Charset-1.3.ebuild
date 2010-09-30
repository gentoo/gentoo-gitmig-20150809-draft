# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MARC-Charset/MARC-Charset-1.3.ebuild,v 1.1 2010/09/30 18:59:19 robbat2 Exp $

EAPI=2

MODULE_AUTHOR="ESUMMERS"
inherit perl-module

DESCRIPTION="convert MARC-8 encoded strings to UTF-8"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND="dev-lang/perl[gdbm]
	dev-perl/XML-SAX
	dev-perl/Class-Accessor"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST=do
