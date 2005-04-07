# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PodParser/PodParser-1.28.ebuild,v 1.12 2005/04/07 20:37:13 hansmi Exp $

inherit perl-module

DESCRIPTION="Print Usage messages based on your own pod"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/M/MA/MAREKR/${P}.readme"
SRC_URI="mirror://cpan/authors/id/M/MA/MAREKR/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"
