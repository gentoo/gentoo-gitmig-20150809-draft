# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-modules/Time-modules-2003.1126.ebuild,v 1.8 2005/08/26 00:27:59 agriffis Exp $

inherit perl-module

DESCRIPTION="A Date/Time Parsing Perl Module"
HOMEPAGE="http://www.cpan.org/modules/by-module/Time/MUIR/modules/${P}.readme"
SRC_URI="mirror://cpan/authors/id/M/MU/MUIR/modules/${P}.tar.gz"
IUSE=""
SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 ~ia64 ppc ~ppc64 sparc x86"

mymake="/usr"

SRC_TEST="do"
