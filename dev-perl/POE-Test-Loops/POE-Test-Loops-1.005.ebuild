# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE-Test-Loops/POE-Test-Loops-1.005.ebuild,v 1.2 2009/06/10 01:42:19 robbat2 Exp $

MODULE_AUTHOR="RCAPUTO"

inherit perl-module

DESCRIPTION="Reusable tests for POE::Loop authors"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-perl/POE"
RDEPEND="${DEPEND}"

SRC_TEST="do"
