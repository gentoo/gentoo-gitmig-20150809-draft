# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MARC-Charset/MARC-Charset-1.0.ebuild,v 1.1 2008/09/29 02:06:59 robbat2 Exp $

MODULE_AUTHOR="ESUMMERS"

inherit perl-module

DESCRIPTION="convert MARC-8 encoded strings to UTF-8"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86 ~ppc"

DEPEND="dev-perl/XML-SAX
	dev-perl/Class-Accessor"
