# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Slurp/File-Slurp-9999.12.ebuild,v 1.10 2007/01/15 19:02:10 mcummings Exp $

inherit perl-module

DESCRIPTION="Efficient Reading/Writing of Complete Files"
HOMEPAGE="http://search.cpan.org/~uri/${P}/"
SRC_URI="mirror://cpan/authors/id/U/UR/URI/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc ~x86"
IUSE=""

SRC_TEST="do"

mydoc="extras/slurp_article.pod"


DEPEND="dev-lang/perl"
