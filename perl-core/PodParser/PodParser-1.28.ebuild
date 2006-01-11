# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/PodParser/PodParser-1.28.ebuild,v 1.2 2006/01/11 09:29:13 mcummings Exp $

inherit perl-module

DESCRIPTION="Base class for creating POD filters and translators"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/M/MA/MAREKR/${P}.readme"
SRC_URI="mirror://cpan/authors/id/M/MA/MAREKR/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"
