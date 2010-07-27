# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PPIx-Utilities/PPIx-Utilities-1.000001.ebuild,v 1.2 2010/07/27 14:57:18 grobian Exp $

EAPI=3

MODULE_AUTHOR="ELLIOTJS"
inherit perl-module

DESCRIPTION="Extensions to PPI"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~ppc-macos"
IUSE="test"

RDEPEND=">=dev-perl/PPI-1.208
	dev-perl/Exception-Class
	dev-perl/Readonly
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Deep )"

SRC_TEST="do"
