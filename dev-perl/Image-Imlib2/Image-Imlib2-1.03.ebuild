# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Image-Imlib2/Image-Imlib2-1.03.ebuild,v 1.1 2005/01/10 14:43:30 vapier Exp $

style=builder
inherit perl-module

DESCRIPTION="Interface to the Imlib2 image library"
HOMEPAGE="http://search.cpan.org/~lbrocard/${P}"
SRC_URI="http://search.cpan.org/CPAN/authors/id/L/LB/LBROCARD/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND=">=media-libs/imlib2-1*
	>=dev-perl/module-build-0.22"
