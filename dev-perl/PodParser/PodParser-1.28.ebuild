# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PodParser/PodParser-1.28.ebuild,v 1.7 2005/02/07 20:22:02 gustavoz Exp $

inherit perl-module

DESCRIPTION="Print Usage messages based on your own pod"
SRC_URI="mirror://cpan/authors/id/M/MA/MAREKR/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/M/MA/MAREKR/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="x86 ~amd64 ~alpha ~ppc sparc ~hppa ~mips ~ia64 ppc64"
IUSE=""

SRC_TEST="do"
