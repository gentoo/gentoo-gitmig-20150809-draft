# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-CAST5_PP/Crypt-CAST5_PP-1.03.ebuild,v 1.5 2006/07/10 14:58:18 agriffis Exp $

inherit perl-module

DESCRIPTION="CAST5 block cipher in pure Perl"
HOMEPAGE="http://search.cpan.org/~bobmath/${P}/"
SRC_URI="mirror://cpan/authors/id/B/BO/BOBMATH/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~amd64 ia64 sparc x86"
IUSE=""

# Tests disabled 6/24/6. The tests rely on a version of Crypt::CBC syntax
# that is no longer valid.
#SRC_TEST="do"
