# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD-Graph3d/GD-Graph3d-0.63.ebuild,v 1.13 2005/08/12 15:11:39 gustavoz Exp $

inherit perl-module

DESCRIPTION="Create 3D Graphs with GD and GD::Graph"
HOMEPAGE="http://www.cpan.org/modules/by-module/GD/${P}.readme"
SRC_URI="mirror://cpan/authors/id/W/WA/WADG/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86 amd64 ppc sparc ppc64"
IUSE=""

DEPEND=">=dev-perl/GD-1.18
	>=dev-perl/GDGraph-1.30
	dev-perl/GDTextUtil"
