# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Per Wigren <wigren@home.se>
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Filter/Filter-1.28.ebuild,v 1.2 2002/05/21 18:14:07 danarmak Exp $

DESCRIPTION="Source Filters for Perl"
HOMEPAGE="http://cpan.valueclick.com/authors/id/P/PM/PMQS/${P}.readme"

S=${WORKDIR}/${P}
SRC_URI="http://cpan.valueclick.com/authors/id/P/PM/PMQS/${P}.tar.gz"


inherit perl-module

mymake="/usr"
