# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/TheSchwartz/TheSchwartz-1.07.ebuild,v 1.4 2009/12/10 21:09:00 ranger Exp $

MODULE_AUTHOR="BRADFITZ"

inherit perl-module

DESCRIPTION="Reliable job queue"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"

DEPEND=">=dev-perl/Data-ObjectDriver-0.06"
RDEPEND="${DEPEND}"

# testsuite broken.
SRC_TEST="never"
