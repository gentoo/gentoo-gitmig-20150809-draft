# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD-SVG/GD-SVG-0.25.ebuild,v 1.7 2005/03/30 22:17:23 gustavoz Exp $

inherit perl-module

DEPEND="dev-perl/GD
		dev-perl/SVG
		"

RDEPEND="${DEPEND}"

DESCRIPTION="Seamlessly enable SVG output from scripts written using GD"
SRC_URI="http://search.cpan.org/CPAN/authors/id/T/TW/TWH/GD-SVG-0.25.tar.gz

http://www.cpan.org/authors/id/I/IL/ILYAZ/modules/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~twh/${P}/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="x86 alpha ~ppc sparc"
