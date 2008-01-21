# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Google-SafeBrowsing-UpdateRequest/Net-Google-SafeBrowsing-UpdateRequest-1.06.ebuild,v 1.4 2008/01/21 23:53:54 maekke Exp $

MODULE_AUTHOR="DANBORN"
inherit perl-module

DESCRIPTION="Update a Google SafeBrowsing table"

IUSE="test"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~ppc x86"
RDEPEND="dev-perl/libwww-perl
		 >=dev-perl/Net-Google-SafeBrowsing-Blocklist-1.04"
DEPEND="${RDEPEND}
		test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
