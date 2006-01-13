# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Tee/IO-Tee-0.64.ebuild,v 1.3 2006/01/13 20:37:23 mcummings Exp $

inherit perl-module

DESCRIPTION="Multiplex output to multiple output handles"
HOMEPAGE="http://search.cpan.org/~kenshan/${P}/"
SRC_URI="mirror://cpan/authors/id/K/KE/KENSHAN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ppc sparc x86"
IUSE=""

SRC_TEST="do"
