# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Filter/Filter-1.28.ebuild,v 1.5 2002/07/31 13:04:21 cselkirk Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Source Filters for Perl"
HOMEPAGE="http://cpan.valueclick.com/authors/id/P/PM/PMQS/${P}.readme"
SRC_URI="http://cpan.valueclick.com/authors/id/P/PM/PMQS/${P}.tar.gz"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc"

mymake="/usr"
