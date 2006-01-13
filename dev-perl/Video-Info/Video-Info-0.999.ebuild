# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Video-Info/Video-Info-0.999.ebuild,v 1.5 2006/01/13 22:32:46 mcummings Exp $

inherit perl-module

DESCRIPTION="Perl extension for getting video info"
HOMEPAGE="http://search.cpan.org/~allenday/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AL/ALLENDAY/${P}.tar.gz"

LICENSE="Artistic"
#LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc x86"
IUSE=""

SRC_TEST="do"
