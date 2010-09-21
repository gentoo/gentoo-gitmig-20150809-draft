# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Getopt-Long-Descriptive/Getopt-Long-Descriptive-0.086.ebuild,v 1.1 2010/09/21 18:59:49 tove Exp $

EAPI=3

MODULE_AUTHOR=RJBS
inherit perl-module

DESCRIPTION="Getopt::Long with usage text"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="test"

RDEPEND=">=dev-perl/Params-Validate-0.91
	dev-perl/IO-stringy
	dev-perl/Sub-Exporter
	virtual/perl-Scalar-List-Utils"
DEPEND="test? ( ${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
