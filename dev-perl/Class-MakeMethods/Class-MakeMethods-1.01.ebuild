# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MakeMethods/Class-MakeMethods-1.01.ebuild,v 1.8 2006/03/12 07:38:59 vapier Exp $

inherit perl-module

DESCRIPTION="Automated method creation module for Perl"
SRC_URI="mirror://cpan/authors/id/E/EV/EVO/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~evo/${P}/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha amd64 arm hppa ia64 ppc s390 sh sparc x86"
IUSE=""

SRC_TEST="do"
