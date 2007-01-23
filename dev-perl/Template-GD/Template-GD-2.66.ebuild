# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Template-GD/Template-GD-2.66.ebuild,v 1.11 2007/01/23 00:19:14 kloeri Exp $

inherit perl-module

DESCRIPTION="GD plugin(s) for the Template Toolkit"
SRC_URI="mirror://cpan/modules/by-module/Template/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/dist/"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~ia64 ppc ~ppc64 sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl
	dev-perl/GD
	dev-perl/GDTextUtil
	dev-perl/GDGraph
	dev-perl/GD-Graph3d
	>=dev-perl/Template-Toolkit-2.15-r1"
