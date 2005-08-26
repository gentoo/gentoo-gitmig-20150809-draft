# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Text-Aspell/Text-Aspell-0.04.ebuild,v 1.6 2005/08/26 00:23:38 agriffis Exp $

inherit perl-module

DESCRIPTION="Perl interface to the GNU Aspell Library"
SRC_URI="mirror://cpan/authors/id/H/HA/HANK/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-authors/id/H/HA/HANK/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="app-text/aspell"
