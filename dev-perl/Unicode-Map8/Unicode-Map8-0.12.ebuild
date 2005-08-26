# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Unicode-Map8/Unicode-Map8-0.12.ebuild,v 1.9 2005/08/26 02:30:41 agriffis Exp $

inherit perl-module

DESCRIPTION="Convert between most 8bit encodings"
SRC_URI="mirror://cpan/authors/id/G/GA/GAAS/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~gaas/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
IUSE=""

DEPEND="${DEPEND}
	>=dev-perl/Unicode-String-2.06"

mydoc="TODO"
