# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-CAST5_PP/Crypt-CAST5_PP-1.03.ebuild,v 1.3 2006/03/30 22:24:56 agriffis Exp $

inherit perl-module

DESCRIPTION="CAST5 block cipher in pure Perl"
HOMEPAGE="http://search.cpan.org/~bobmath/${P}/"
SRC_URI="mirror://cpan/authors/id/B/BO/BOBMATH/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~ia64 sparc x86"
IUSE=""

SRC_TEST="do"
