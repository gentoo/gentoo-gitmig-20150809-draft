# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Carp-Clan/Carp-Clan-5.8.ebuild,v 1.5 2006/12/24 00:17:58 dertobi123 Exp $

inherit perl-module

DESCRIPTION="Report errors from perspective of caller of a clan of modules"
HOMEPAGE="http://search.cpan.org/~jjore/${P}/"
SRC_URI="mirror://cpan/authors/id/J/JJ/JJORE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha amd64 arm ia64 ppc ~ppc64 s390 sh sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
