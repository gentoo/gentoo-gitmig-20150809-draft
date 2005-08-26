# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-CRL/OpenCA-CRL-0.9.17.ebuild,v 1.10 2005/08/25 23:58:56 agriffis Exp $

inherit perl-module

DESCRIPTION="The perl OpenCA::CRL Module"
SRC_URI="mirror://cpan/authors/id/M/MA/MADWOLF/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.readme"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 ~ia64 ppc sparc x86"
IUSE=""

SRC_TEST="do"

export OPTIMIZE="${CFLAGS}"
