# Copyright 2001-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/OpenCA-CRL/OpenCA-CRL-0.9.17.ebuild,v 1.3 2004/07/14 19:54:38 agriffis Exp $

inherit perl-module

DESCRIPTION="The perl OpenCA::CRL Module"
SRC_URI="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/authors/id/M/MA/MADWOLF/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha"
IUSE=""

SRC_TEST="do"

export OPTIMIZE="${CFLAGS}"
