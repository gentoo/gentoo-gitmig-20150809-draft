# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Command/Test-Command-0.08.ebuild,v 1.1 2010/06/27 00:10:03 ssuominen Exp $

MODULE_AUTHOR=DANBOO
inherit perl-module

DESCRIPTION="Test routines for external commands"

LICENSE="|| ( Artistic GPL-1 GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

RDEPEND=""
DEPEND="virtual/perl-Module-Build
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"
