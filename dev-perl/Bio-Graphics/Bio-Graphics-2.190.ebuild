# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bio-Graphics/Bio-Graphics-2.190.ebuild,v 1.2 2011/02/07 18:37:35 robbat2 Exp $

EAPI="3"

MODULE_AUTHOR=LDS
MODULE_VERSION=2.19
inherit perl-module

DESCRIPTION="Generate images from Bio::Seq objects for visualization purposes"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/GD
	dev-perl/Statistics-Descriptive"
DEPEND="${RDEPEND}
	virtual/perl-Module-Build"

SRC_TEST=no
