# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-GlobRef/MooseX-GlobRef-0.07.ebuild,v 1.3 2010/02/03 17:37:51 tove Exp $

EAPI=2

MODULE_AUTHOR="DEXTER"
inherit perl-module

DESCRIPTION="Store a Moose object in glob reference"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Moose"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"
#	test? ( >=dev-perl/Test-Unit-Lite-0.12
#		dev-perl/Test-Assert
#		virtual/perl-parent )"
