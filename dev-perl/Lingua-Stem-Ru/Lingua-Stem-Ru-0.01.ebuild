# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Lingua-Stem-Ru/Lingua-Stem-Ru-0.01.ebuild,v 1.2 2005/01/22 15:34:28 mcummings Exp $

inherit perl-module

DESCRIPTION="Porter's stemming algorithm for Russian (KOI8-R only)"
HOMEPAGE="http://search.cpan.org/~algdr/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AL/ALGDR/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 ~sparc"
IUSE=""

SRC_TEST="do"
