# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Want/Want-0.07.ebuild,v 1.1 2004/07/30 10:03:12 mcummings Exp $

inherit perl-module

DESCRIPTION="A generalisation of wantarray"
SRC_URI="http://search.cpan.org/CPAN/authors/id/R/RO/ROBIN/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/~robin/${P}/"
SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~alpha ~hppa"
IUSE=""

SRC_TEST="do"
