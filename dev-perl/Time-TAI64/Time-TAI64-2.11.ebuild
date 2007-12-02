# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Time-TAI64/Time-TAI64-2.11.ebuild,v 1.1 2007/12/02 10:06:23 robbat2 Exp $

MODULE_AUTHOR="JOVAL"

inherit perl-module

DESCRIPTION="Time manipulation in the TAI64* formats"
IUSE=""
SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~x86 ~ppc"
DEPEND="virtual/perl-Test-Simple
		virtual/perl-Time-HiRes
		dev-lang/perl"

