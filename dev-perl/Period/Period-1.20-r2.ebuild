# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Period/Period-1.20-r2.ebuild,v 1.1 2002/07/08 21:17:17 sunflare Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Period is a time period Perl module."
SRC_URI="http://www.cpan.org/modules/by-module/Time/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Time/${P}.readme"
LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86"

DEPEND="sys-devel/perl"

RDEPEND=${DEPEND}
