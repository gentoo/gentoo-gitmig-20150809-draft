# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/DateManip/DateManip-5.50.ebuild,v 1.1 2008/05/07 08:16:44 tove Exp $

inherit perl-module

DESCRIPTION="Perl date manipulation routines"
HOMEPAGE="http://search.cpan.org/dist/Date-Manip"
SRC_URI="mirror://cpan/authors/id/S/SB/SBECK/Date-Manip-${PV}.tar.gz"
SRC_TEST="do"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""


RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}"
#	dev-perl/module-build"

# Build.PL doesn't work with 5.50
PREFER_BUILDPL=no

S=${WORKDIR}/Date-Manip-${PV}

mydoc="HISTORY TODO"
