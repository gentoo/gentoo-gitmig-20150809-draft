# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-Getopt/MooseX-Getopt-0.18.ebuild,v 1.1 2009/06/23 07:44:01 robbat2 Exp $

EAPI=2
MODULE_AUTHOR="RJBS"

inherit perl-module

DESCRIPTION="A Moose role for processing command line options"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/Test-Exception-0.27
	dev-perl/Getopt-Long-Descriptive
	dev-perl/Moose"
RDEPEND="${DEPEND}"
