# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MARC-Record/MARC-Record-2.0.0.ebuild,v 1.2 2009/01/17 22:28:55 robbat2 Exp $

MODULE_AUTHOR="MIKERY"

inherit perl-module

DESCRIPTION="MARC manipulation (library bibliographic)"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
