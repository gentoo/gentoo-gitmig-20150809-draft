# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Period/Period-1.20-r2.ebuild,v 1.4 2002/08/01 04:04:10 cselkirk Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Period is a time period Perl module."
SRC_URI="http://www.cpan.org/modules/by-module/Time/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Time/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc"

DEPEND=${DEPEND}
