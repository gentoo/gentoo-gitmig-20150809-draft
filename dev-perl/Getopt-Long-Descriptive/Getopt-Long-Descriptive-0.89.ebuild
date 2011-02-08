# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Getopt-Long-Descriptive/Getopt-Long-Descriptive-0.89.ebuild,v 1.1 2011/02/08 07:22:01 tove Exp $

EAPI=3

MODULE_AUTHOR=RJBS
MODULE_VERSION=0.089
inherit perl-module

DESCRIPTION="Getopt::Long with usage text"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~ppc-macos ~x86-solaris"
IUSE="test"

RDEPEND=">=dev-perl/Params-Validate-0.91
	dev-perl/IO-stringy
	dev-perl/Sub-Exporter
	virtual/perl-Scalar-List-Utils"
DEPEND="test? ( ${RDEPEND}
		dev-perl/Test-Pod
		dev-perl/Test-Pod-Coverage )"

SRC_TEST=do
