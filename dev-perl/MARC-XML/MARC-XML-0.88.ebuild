# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MARC-XML/MARC-XML-0.88.ebuild,v 1.1 2008/09/29 02:07:52 robbat2 Exp $

MODULE_AUTHOR="KADOS"

inherit perl-module

DESCRIPTION="A subclass of MARC.pm to provide XML support"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-perl/XML-SAX
		dev-perl/MARC-Record"
