# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-Piece/Time-Piece-1.11.ebuild,v 1.9 2007/06/30 15:59:29 armin76 Exp $

inherit perl-module

DESCRIPTION="Object Oriented time objects"
HOMEPAGE="http://search.cpan.org/~msergeant/"
SRC_URI="mirror://cpan/authors/id/M/MS/MSERGEANT/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"


DEPEND="dev-lang/perl"
