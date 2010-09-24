# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-GlobRef/MooseX-GlobRef-0.0701.ebuild,v 1.1 2010/09/24 17:41:11 tove Exp $

EAPI=3

MODULE_AUTHOR="DEXTER"
inherit perl-module

DESCRIPTION="Store a Moose object in glob reference"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-perl/Moose-0.96"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build
	test? ( >=dev-perl/Test-Unit-Lite-0.12
		dev-perl/Test-Assert
		virtual/perl-parent )"

SRC_TEST=do
