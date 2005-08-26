# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD-SVG/GD-SVG-0.25.ebuild,v 1.10 2005/08/26 02:20:57 agriffis Exp $

inherit perl-module

DEPEND="dev-perl/GD
		dev-perl/SVG
		"

RDEPEND="${DEPEND}"

DESCRIPTION="Seamlessly enable SVG output from scripts written using GD"
SRC_URI="mirror://cpan/authors/id/T/TW/TWH/GD-SVG-0.25.tar.gz"
HOMEPAGE="http://search.cpan.org/~twh/${P}/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha ~amd64 ~ia64 ~ppc sparc x86"
