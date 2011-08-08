# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-CSV_XS/Text-CSV_XS-0.820.0.ebuild,v 1.2 2011/08/08 20:13:25 grobian Exp $

EAPI=4

MODULE_A_EXT=tgz
MODULE_AUTHOR=HMBRAND
MODULE_VERSION=0.82
inherit perl-module

DESCRIPTION="comma-separated values manipulation routines"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="test"

RDEPEND=""
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST="parallel"
