# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateManip/DateManip-5.42a-r1.ebuild,v 1.6 2004/04/25 21:02:39 vapier Exp $

inherit perl-module eutils

DESCRIPTION="Perl date manipulation routines."
HOMEPAGE="http://www.perl.com/CPAN/authors/id/SBECK/${P}.readme"
SRC_URI="http://www.cpan.org/modules/by-module/Date/SBECK/${P}.tar.gz"

LICENSE="Artistic | GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc sparc ~alpha ~mips hppa ~amd64 s390"
IUSE=""

mydoc="HISTORY TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/safe-taint-check.patch
}
