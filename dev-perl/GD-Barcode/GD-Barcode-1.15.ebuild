# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GD-Barcode/GD-Barcode-1.15.ebuild,v 1.4 2008/05/07 09:15:40 tove Exp $

inherit perl-module

DESCRIPTION="GD::Barcode - Create barcode image with GD"
HOMEPAGE="http://search.cpan.org/~kwitknr/${P}/"
SRC_URI="mirror://cpan/authors/id/K/KW/KWITKNR/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}
	dev-perl/GD"
