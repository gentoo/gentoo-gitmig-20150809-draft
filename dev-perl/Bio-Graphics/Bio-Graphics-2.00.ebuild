# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bio-Graphics/Bio-Graphics-2.00.ebuild,v 1.1 2010/02/14 08:42:46 tove Exp $

EAPI="2"

MODULE_AUTHOR=LDS
inherit perl-module

DESCRIPTION="Generate images from Bio::Seq objects for visualization purposes"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/GD"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=no
