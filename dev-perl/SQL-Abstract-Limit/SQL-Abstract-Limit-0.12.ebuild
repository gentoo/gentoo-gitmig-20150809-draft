# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Abstract-Limit/SQL-Abstract-Limit-0.12.ebuild,v 1.1 2008/09/29 02:06:05 robbat2 Exp $

MODULE_AUTHOR="DAVEBAIRD"

inherit perl-module

DESCRIPTION="portable LIMIT emulation"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86 ~ppc"

DEPEND="dev-perl/SQL-Abstract
	dev-perl/Test-Exception
	dev-perl/DBI"
