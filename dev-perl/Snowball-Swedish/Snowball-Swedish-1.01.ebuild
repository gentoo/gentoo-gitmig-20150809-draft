# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Snowball-Swedish/Snowball-Swedish-1.01.ebuild,v 1.1 2004/10/06 23:19:05 mcummings Exp $

inherit perl-module

DESCRIPTION="Porters stemming algorithm for Swedish"
HOMEPAGE="http://search.cpan.org/~asksh/${P}/"
SRC_URI="mirror://cpan/authors/id/A/AS/ASKSH/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~x86 ~sparc"
IUSE=""

SRC_TEST="do"
