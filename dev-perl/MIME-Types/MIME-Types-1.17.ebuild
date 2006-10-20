# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/MIME-Types/MIME-Types-1.17.ebuild,v 1.5 2006/10/20 19:51:45 kloeri Exp $

inherit perl-module

DESCRIPTION="Definition of MIME types"
SRC_URI="mirror://cpan/authors/id/M/MA/MARKOV/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~markov/${P}/"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~hppa ia64 ~ppc ~ppc64 sparc ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-lang/perl"
