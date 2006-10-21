# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PadWalker/PadWalker-1.0.ebuild,v 1.1 2006/10/21 17:08:52 mcummings Exp $

inherit perl-module

DESCRIPTION="play with other peoples' lexical variables"
HOMEPAGE="http://search.cpan.org/~robin/${P}/"
SRC_URI="mirror://cpan/authors/id/R/RO/ROBIN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ~sparc"
IUSE=""

SRC_TEST="do"
