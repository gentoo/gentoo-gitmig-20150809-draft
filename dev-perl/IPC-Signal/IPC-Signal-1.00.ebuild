# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-Signal/IPC-Signal-1.00.ebuild,v 1.8 2006/08/17 21:21:45 mcummings Exp $

inherit perl-module

DESCRIPTION="Translate signal names to/from numbers"
SRC_URI="mirror://cpan/authors/id/R/RO/ROSCH/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/~rosch/${P}/"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 sparc x86"


DEPEND="dev-lang/perl"
RDEPEND="${DEPEND}"
