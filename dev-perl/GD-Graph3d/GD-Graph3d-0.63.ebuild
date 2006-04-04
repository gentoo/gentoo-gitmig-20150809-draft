# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD-Graph3d/GD-Graph3d-0.63.ebuild,v 1.15 2006/04/04 19:32:12 agriffis Exp $

inherit perl-module

DESCRIPTION="Create 3D Graphs with GD and GD::Graph"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"
SRC_URI="mirror://cpan/authors/id/W/WA/WADG/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ia64 ppc ppc64 sparc x86"
IUSE=""

DEPEND=">=dev-perl/GD-1.18
	>=dev-perl/GDGraph-1.30
	dev-perl/GDTextUtil"
