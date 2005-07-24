# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Tee/IO-Tee-0.64.ebuild,v 1.1 2005/07/24 13:53:49 mcummings Exp $

inherit perl-module

DESCRIPTION="Multiplex output to multiple output handles"
HOMEPAGE="http://search.cpan.org/~kenshan/${P}/"
SRC_URI="mirror://cpan/authors/id/K/KE/KENSHAN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"
