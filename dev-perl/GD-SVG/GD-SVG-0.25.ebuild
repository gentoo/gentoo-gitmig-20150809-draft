# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD-SVG/GD-SVG-0.25.ebuild,v 1.1 2004/01/09 02:43:15 sediener Exp $

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
KEYWORDS="~x86"
