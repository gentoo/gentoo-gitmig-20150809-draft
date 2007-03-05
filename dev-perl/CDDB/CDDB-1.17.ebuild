# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/CDDB/CDDB-1.17.ebuild,v 1.8 2007/03/05 11:16:04 ticho Exp $

inherit perl-module

DESCRIPTION="high-level interface to cddb/freedb protocol"
SRC_URI="mirror://cpan/authors/id/R/RC/RCAPUTO/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~rcaputo/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ia64 ppc sparc x86"
IUSE=""
DEPEND="dev-lang/perl"
