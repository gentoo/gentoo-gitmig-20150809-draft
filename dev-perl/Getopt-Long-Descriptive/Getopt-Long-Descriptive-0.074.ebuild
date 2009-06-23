# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Getopt-Long-Descriptive/Getopt-Long-Descriptive-0.074.ebuild,v 1.1 2009/06/23 07:41:24 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="HDP"

inherit perl-module

DESCRIPTION="Getopt::Long with usage text and validation"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/Params-Validate-0.91
	dev-perl/IO-stringy"
RDEPEND="${DEPEND}"
