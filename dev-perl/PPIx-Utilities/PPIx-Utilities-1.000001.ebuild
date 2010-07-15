# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PPIx-Utilities/PPIx-Utilities-1.000001.ebuild,v 1.1 2010/07/15 13:28:59 tove Exp $

EAPI=3

MODULE_AUTHOR="ELLIOTJS"
inherit perl-module

DESCRIPTION="Extensions to PPI"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/PPI-1.208
	dev-perl/Exception-Class
	dev-perl/Readonly
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Deep )"

SRC_TEST="do"
