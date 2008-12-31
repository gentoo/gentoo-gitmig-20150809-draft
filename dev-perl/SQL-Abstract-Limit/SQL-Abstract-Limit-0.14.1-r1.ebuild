# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/SQL-Abstract-Limit/SQL-Abstract-Limit-0.14.1-r1.ebuild,v 1.2 2008/12/31 03:20:58 mr_bones_ Exp $

inherit versionator
MODULE_AUTHOR="DAVEBAIRD"
MY_P="${PN}-$(delete_version_separator 2)"
S="${WORKDIR}/${MY_P}"

inherit perl-module

DESCRIPTION="portable LIMIT emulation"

IUSE="test"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

RDEPEND="dev-perl/SQL-Abstract
		 dev-perl/DBI"
DEPEND="${RDEPEND}
		test? ( dev-perl/Test-Deep
				dev-perl/Test-Exception )"
