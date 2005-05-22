# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateManip/DateManip-5.42a-r1.ebuild,v 1.17 2005/05/22 02:05:11 vapier Exp $

inherit perl-module eutils

DESCRIPTION="Perl date manipulation routines"
HOMEPAGE="http://www.perl.com/CPAN/authors/id/SBECK/${P}.readme"
SRC_URI="mirror://cpan/authors/id/S/SB/SBECK/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

mydoc="HISTORY TODO"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/safe-taint-check.patch
}
