# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Want/Want-0.07.ebuild,v 1.8 2006/03/13 22:09:04 gustavoz Exp $

inherit perl-module

DESCRIPTION="A generalisation of wantarray"
SRC_URI="mirror://cpan/authors/id/R/RO/ROBIN/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/~robin/${P}/"
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ia64 ~ppc sparc x86"
IUSE=""

SRC_TEST="do"
