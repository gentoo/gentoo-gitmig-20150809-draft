# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-Slurp/File-Slurp-9999.06.ebuild,v 1.4 2005/04/09 01:22:02 gustavoz Exp $

inherit perl-module

DESCRIPTION="Efficient Reading/Writing of Complete Files"
HOMEPAGE="http://search.cpan.org/~uri/${P}/"
SRC_URI="mirror://cpan/authors/id/U/UR/URI/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="x86 sparc ~amd64 ~alpha ~ppc"
IUSE=""

SRC_TEST="do"

mydoc="extras/slurp_article.pod"
