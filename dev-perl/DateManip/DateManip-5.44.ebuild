# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateManip/DateManip-5.44.ebuild,v 1.8 2006/02/25 23:53:14 kumba Exp $

inherit perl-module eutils

DESCRIPTION="Perl date manipulation routines"
HOMEPAGE="http://www.perl.com/CPAN/authors/id/SBECK/DateManip-5.44.readme"
SRC_URI="mirror://cpan/authors/id/S/SB/SBECK/${P}.tar.gz"
SRC_TEST="do"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

mydoc="HISTORY TODO"
