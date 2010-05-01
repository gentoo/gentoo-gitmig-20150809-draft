# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Portability-Files/Test-Portability-Files-0.05.ebuild,v 1.1 2010/05/01 20:08:22 weaver Exp $
EAPI=2
MODULE_AUTHOR=SAPER
inherit perl-module

DESCRIPTION="Check file names portability"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
COMMON_DEPEND="
	virtual/perl-File-Spec
	virtual/perl-Test-Simple
"
DEPEND="
	${COMMON_DEPEND}
"
RDEPEND="
	${COMMON_DEPEND}
"
SRC_TEST="do"
