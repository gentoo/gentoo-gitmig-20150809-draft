# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PPIx-Utilities/PPIx-Utilities-1.001000.ebuild,v 1.2 2011/02/10 23:41:38 hwoarang Exp $

EAPI=3

MODULE_AUTHOR="ELLIOTJS"
inherit perl-module

DESCRIPTION="Extensions to PPI"

SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc ~x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE="test"

RDEPEND=">=dev-perl/PPI-1.208
	dev-perl/Exception-Class
	dev-perl/Readonly
	virtual/perl-Scalar-List-Utils"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( dev-perl/Test-Deep )"

SRC_TEST="do"
