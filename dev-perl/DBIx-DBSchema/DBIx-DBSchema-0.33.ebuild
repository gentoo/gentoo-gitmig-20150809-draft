# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DBIx-DBSchema/DBIx-DBSchema-0.33.ebuild,v 1.6 2008/03/19 02:58:41 jer Exp $

inherit perl-module

DESCRIPTION="Database-independent schema objects"
HOMEPAGE="http://search.cpan.org/~ivan/"
SRC_URI="mirror://cpan/authors/id/I/IV/IVAN/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/DBI
	dev-perl/FreezeThaw
	dev-lang/perl"
