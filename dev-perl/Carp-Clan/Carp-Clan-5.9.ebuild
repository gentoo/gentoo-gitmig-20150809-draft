# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Carp-Clan/Carp-Clan-5.9.ebuild,v 1.10 2007/08/21 13:46:32 jer Exp $

inherit perl-module

DESCRIPTION="Report errors from perspective of caller of a clan of modules"
HOMEPAGE="http://search.cpan.org/~jjore/"
SRC_URI="mirror://cpan/authors/id/J/JJ/JJORE/${P}.tar.gz"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="dev-perl/Test-Exception
		dev-lang/perl"
DEPEND="${RDEPEND}"

SRC_TEST="do"
