# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CQL-Parser/CQL-Parser-1.0.ebuild,v 1.1 2008/12/23 08:12:00 robbat2 Exp $

MODULE_AUTHOR="ESUMMERS"

inherit perl-module

DESCRIPTION="compiles CQL strings into parse trees of Node subtypes."

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/Test-Exception-0.27
	dev-perl/Clone
	>=dev-perl/Class-Accessor-0.31
	>=dev-perl/String-Tokenizer-0.05"
