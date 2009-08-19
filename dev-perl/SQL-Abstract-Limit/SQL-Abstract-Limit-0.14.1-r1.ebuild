# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Abstract-Limit/SQL-Abstract-Limit-0.14.1-r1.ebuild,v 1.3 2009/08/19 15:13:19 tove Exp $

inherit versionator
MODULE_AUTHOR="DAVEBAIRD"
MY_P="${PN}-$(delete_version_separator 2)"
S="${WORKDIR}/${MY_P}"

inherit perl-module

DESCRIPTION="portable LIMIT emulation"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="test"

RDEPEND="dev-perl/SQL-Abstract
		 dev-perl/DBI"
DEPEND="${RDEPEND}
		virtual/perl-Module-Build
		test? ( dev-perl/Test-Deep
				dev-perl/Test-Exception )"

SRC_TEST=do
