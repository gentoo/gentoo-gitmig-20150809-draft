# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-UTF8simple/Unicode-UTF8simple-1.06.ebuild,v 1.6 2006/07/24 01:41:28 ticho Exp $

inherit perl-module

DESCRIPTION="Conversions to/from UTF8 from/to charactersets"
HOMEPAGE="http://search.cpan.org/search?query=${PN}"
SRC_URI="mirror://cpan/authors/id/G/GU/GUS/${P}.tar.gz"


IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ppc sparc x86"

SRC_TEST="do"
