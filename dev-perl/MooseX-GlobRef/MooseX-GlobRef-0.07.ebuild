# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MooseX-GlobRef/MooseX-GlobRef-0.07.ebuild,v 1.2 2009/08/10 21:46:17 tove Exp $

EAPI=2
MODULE_AUTHOR="DEXTER"

inherit perl-module

DESCRIPTION="Store a Moose object in glob reference"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86"

DEPEND=">=dev-perl/Test-Unit-Lite-0.12
	virtual/perl-parent
	dev-perl/Test-Assert
	dev-perl/Moose"
RDEPEND="${DEPEND}"
