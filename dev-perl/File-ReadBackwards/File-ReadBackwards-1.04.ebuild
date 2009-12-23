# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-ReadBackwards/File-ReadBackwards-1.04.ebuild,v 1.12 2009/12/23 18:14:55 grobian Exp $

inherit perl-module

DESCRIPTION="The Perl File-ReadBackwards Module"
SRC_URI="mirror://cpan/authors/id/U/UR/URI/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~uri/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ~ppc ppc64 sparc x86 ~x86-solaris"
SRC_TEST="do"

DEPEND="dev-lang/perl"
