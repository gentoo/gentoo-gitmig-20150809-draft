# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Getopt-Long-Descriptive/Getopt-Long-Descriptive-0.074.ebuild,v 1.2 2009/06/23 13:14:57 tove Exp $

EAPI=2

MODULE_AUTHOR=HDP
inherit perl-module

DESCRIPTION="Getopt::Long with usage text"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Params-Validate-0.91
	dev-perl/IO-stringy
	virtual/perl-Scalar-List-Utils"
DEPEND="test? ( ${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
