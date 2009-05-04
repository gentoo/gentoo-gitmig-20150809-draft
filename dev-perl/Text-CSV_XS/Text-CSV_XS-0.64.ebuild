# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CSV_XS/Text-CSV_XS-0.64.ebuild,v 1.6 2009/05/04 16:06:55 armin76 Exp $

EAPI=2

MODULE_AUTHOR=HMBRAND
MODULE_A=${P}.tgz
inherit perl-module

DESCRIPTION="comma-separated values manipulation routines"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="do"
