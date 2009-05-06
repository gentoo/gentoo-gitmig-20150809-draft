# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Data-Compare/Data-Compare-1.21.ebuild,v 1.5 2009/05/06 19:22:55 jer Exp $

MODULE_AUTHOR=DCANTRELL
inherit perl-module

DESCRIPTION="compare perl data structures"

SLOT="0"
KEYWORDS="amd64 hppa ia64 ~ppc sparc x86"
IUSE="test"

RDEPEND="dev-perl/File-Find-Rule
	dev-perl/Scalar-Properties
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Clone
		dev-perl/Test-Pod )"

SRC_TEST="do"
