# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PlRPC/PlRPC-0.2020-r1.ebuild,v 1.1 2007/06/25 16:02:12 mcummings Exp $

inherit perl-module

S=${WORKDIR}/${PN}

DESCRIPTION="The Perl RPC Module"
SRC_URI="mirror://cpan/authors/id/M/MN/MNOONING/${PN}/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mnooning/"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

PATCHES="${FILESDIR}/perldoc-remove.patch"

DEPEND=">=virtual/perl-Storable-1.0.7
	>=dev-perl/Net-Daemon-0.34
	dev-lang/perl"
