# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Image-Imlib2/Image-Imlib2-1.02.ebuild,v 1.4 2004/10/16 23:57:22 rac Exp $

inherit perl-module

DESCRIPTION="Interface to the Imlib2 image library"
HOMEPAGE="http://search.cpan.org/~lbrocard/${P}"
SRC_URI="http://search.cpan.org/CPAN/authors/id/L/LB/LBROCARD/${P}.tar.gz"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"

KEYWORDS="~x86 ~amd64 ~ppc ~alpha ~sparc"
IUSE=""
DEPEND=">=media-libs/imlib2-1*
		>=dev-perl/module-build-0.22"
style=builder
