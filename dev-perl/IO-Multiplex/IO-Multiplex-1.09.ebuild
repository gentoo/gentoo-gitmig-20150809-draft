# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Multiplex/IO-Multiplex-1.09.ebuild,v 1.5 2007/07/10 23:33:26 mr_bones_ Exp $

inherit perl-module

DESCRIPTION="Manage IO on many file handles "
HOMEPAGE="http://search.cpan.org/~bbb/"
SRC_URI="mirror://cpan/authors/id/B/BB/BBB/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ppc64 sparc ~x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
