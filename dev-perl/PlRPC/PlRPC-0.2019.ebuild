# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PlRPC/PlRPC-0.2019.ebuild,v 1.5 2007/08/25 13:17:25 vapier Exp $

inherit perl-module

DESCRIPTION="The Perl RPC Module"
SRC_URI="mirror://cpan/authors/id/M/MN/MNOONING/${PN}/${P}.tar.gz"
HOMEPAGE="http://search.cpan.org/~mnooning/"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha ~amd64 arm ~hppa ia64 ~mips ~ppc ppc64 s390 sh sparc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=virtual/perl-Storable-1.0.7
	>=dev-perl/Net-Daemon-0.34
	dev-lang/perl"
