# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/File-ReadBackwards/File-ReadBackwards-1.04.ebuild,v 1.11 2007/07/10 23:33:28 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="The Perl File-ReadBackwards Module"
SRC_URI="mirror://cpan/authors/id/U/UR/URI/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~uri/"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 hppa ia64 ~ppc ppc64 sparc x86"
SRC_TEST="do"

DEPEND="dev-lang/perl"
