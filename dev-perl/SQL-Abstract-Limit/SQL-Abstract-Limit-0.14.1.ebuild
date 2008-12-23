# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Abstract-Limit/SQL-Abstract-Limit-0.14.1.ebuild,v 1.1 2008/12/23 08:51:38 robbat2 Exp $

inherit versionator
MODULE_AUTHOR="DAVEBAIRD"
MY_P="${PN}-$(delete_version_separator 2)"

inherit perl-module

DESCRIPTION="portable LIMIT emulation"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-perl/SQL-Abstract
	dev-perl/Test-Exception
	dev-perl/DBI"
