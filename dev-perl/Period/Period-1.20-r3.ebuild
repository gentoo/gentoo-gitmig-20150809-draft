# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Period/Period-1.20-r3.ebuild,v 1.4 2003/02/13 11:18:00 vapier Exp $

inherit perl-module

S=${WORKDIR}/${P}
DESCRIPTION="Period is a time period Perl module."
SRC_URI="http://www.cpan.org/modules/by-module/Time/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Time/${P}.readme"

SLOT="0"
LICENSE="Artistic | GPL-2"
KEYWORDS="x86 ppc sparc alpha"

DEPEND=${DEPEND}
