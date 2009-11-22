# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Bio-Graphics/Bio-Graphics-1.992.ebuild,v 1.1 2009/11/22 10:47:53 robbat2 Exp $

EAPI="2"

MODULE_AUTHOR=LDS
inherit perl-module

DESCRIPTION="Generate images from Bio::Seq objects for visualization purposes"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-perl/GD"
RDEPEND="${DEPEND}"

SRC_TEST=no
