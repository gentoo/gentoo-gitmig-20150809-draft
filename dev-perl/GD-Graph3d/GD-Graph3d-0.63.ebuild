# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD-Graph3d/GD-Graph3d-0.63.ebuild,v 1.23 2010/12/03 02:24:46 xmw Exp $

inherit perl-module

DESCRIPTION="Create 3D Graphs with GD and GD::Graph"
HOMEPAGE="http://search.cpan.org/~wadg/"
SRC_URI="mirror://cpan/authors/id/W/WA/WADG/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ~arm ia64 ppc ppc64 sparc x86 ~x86-fbsd ~x86-solaris"
IUSE=""

DEPEND=">=dev-perl/GD-1.18
	>=dev-perl/GDGraph-1.30
	dev-perl/GDTextUtil
	dev-lang/perl"
