# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Crypt-CAST5_PP/Crypt-CAST5_PP-1.04.ebuild,v 1.8 2010/01/09 18:25:26 grobian Exp $

inherit perl-module

DESCRIPTION="CAST5 block cipher in pure Perl"
HOMEPAGE="http://search.cpan.org/~bobmath/${P}/"
SRC_URI="mirror://cpan/authors/id/B/BO/BOBMATH/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="amd64 hppa ia64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

SRC_TEST="do"
DEPEND="dev-lang/perl"
