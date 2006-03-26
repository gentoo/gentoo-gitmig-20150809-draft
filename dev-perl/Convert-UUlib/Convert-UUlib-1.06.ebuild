# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Convert-UUlib/Convert-UUlib-1.06.ebuild,v 1.2 2006/03/26 13:59:38 mcummings Exp $

inherit perl-module

DESCRIPTION="A Perl interface to the uulib library"
SRC_URI="mirror://cpan/authors/id/M/ML/MLEHMANN/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Convert/MLEHMANN/${P}.readme"

SLOT="0"
LICENSE="Artistic GPL-2"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 sparc x86"
IUSE=""

SRC_TEST="do"
