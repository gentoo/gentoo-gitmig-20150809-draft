# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Google-SafeBrowsing-UpdateRequest/Net-Google-SafeBrowsing-UpdateRequest-1.06.ebuild,v 1.3 2007/10/20 20:35:20 robbat2 Exp $

MODULE_AUTHOR="DANBORN"
inherit perl-module

DESCRIPTION="Update a Google SafeBrowsing table"

IUSE="test"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86 ~ppc"
RDEPEND="dev-perl/libwww-perl
		 >=dev-perl/Net-Google-SafeBrowsing-Blocklist-1.04"
DEPEND="${RDEPEND}
		test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
