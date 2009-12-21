# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/POE-Test-Loops/POE-Test-Loops-1.020.ebuild,v 1.2 2009/12/21 16:42:25 armin76 Exp $

EAPI=2

MODULE_AUTHOR="RCAPUTO"
inherit perl-module

DESCRIPTION="Reusable tests for POE::Loop authors"

SLOT="0"
KEYWORDS="~amd64 ~sparc ~x86"
IUSE=""

DEPEND="dev-perl/POE"
RDEPEND="${DEPEND}"

SRC_TEST="do"
