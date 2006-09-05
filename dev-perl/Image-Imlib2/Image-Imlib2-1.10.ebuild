# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Image-Imlib2/Image-Imlib2-1.10.ebuild,v 1.7 2006/09/05 13:28:47 gustavoz Exp $

inherit perl-module

DESCRIPTION="Interface to the Imlib2 image library"
HOMEPAGE="http://search.cpan.org/~lbrocard/${P}"
SRC_URI="mirror://cpan/authors/id/L/LB/LBROCARD/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 ~ia64 ~ppc sparc ~x86"
IUSE=""

DEPEND=">=media-libs/imlib2-1
	>=dev-perl/module-build-0.28
	dev-perl/ExtUtils-CBuilder
	dev-lang/perl"
RDEPEND="${DEPEND}"


