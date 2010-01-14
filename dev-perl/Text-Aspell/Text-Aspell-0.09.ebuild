# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Aspell/Text-Aspell-0.09.ebuild,v 1.6 2010/01/14 15:12:17 grobian Exp $

inherit perl-module

DESCRIPTION="Perl interface to the GNU Aspell Library"
SRC_URI="mirror://cpan/authors/id/H/HA/HANK/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~hank/"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ia64 ~mips ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

# Disabling tests for now - see bug #147897 --ian
#SRC_TEST="do"

DEPEND="app-text/aspell
	dev-lang/perl"
