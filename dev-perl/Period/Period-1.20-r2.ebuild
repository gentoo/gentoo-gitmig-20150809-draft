# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Period/Period-1.20-r2.ebuild,v 1.2 2002/07/25 04:13:27 seemant Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Period is a time period Perl module."
SRC_URI="http://www.cpan.org/modules/by-module/Time/${P}.tar.gz"
SLOT="0"
HOMEPAGE="http://www.cpan.org/modules/by-module/Time/${P}.readme"
LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86"

SLOT="0"
DEPEND="sys-devel/perl"

RSLOT="0"
DEPEND=${DEPEND}
