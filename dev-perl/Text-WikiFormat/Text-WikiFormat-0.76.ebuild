# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-WikiFormat/Text-WikiFormat-0.76.ebuild,v 1.6 2006/01/13 22:26:25 mcummings Exp $

inherit perl-module

DESCRIPTION="Translate Wiki formatted text into other formats"
SRC_URI="mirror://cpan/authors/id/C/CH/CHROMATIC/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~chromatic/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc sparc x86"

DEPEND="dev-perl/URI
		perl-core/Scalar-List-Utils
		dev-perl/module-build"
IUSE=""

SRC_TEST="do"
