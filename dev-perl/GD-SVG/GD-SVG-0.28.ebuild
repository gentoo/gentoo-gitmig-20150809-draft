# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD-SVG/GD-SVG-0.28.ebuild,v 1.10 2012/03/25 15:06:20 armin76 Exp $

inherit perl-module

DEPEND="dev-perl/GD
	dev-perl/SVG
	dev-lang/perl"

DESCRIPTION="Seamlessly enable SVG output from scripts written using GD"
SRC_URI="mirror://cpan/authors/id/T/TW/TWH/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~twh/${P}/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~ppc x86"
SRC_TEST="do"
