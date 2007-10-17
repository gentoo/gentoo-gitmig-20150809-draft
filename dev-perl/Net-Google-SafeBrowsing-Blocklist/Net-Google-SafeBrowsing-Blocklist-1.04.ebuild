# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Net-Google-SafeBrowsing-Blocklist/Net-Google-SafeBrowsing-Blocklist-1.04.ebuild,v 1.2 2007/10/17 16:50:05 mr_bones_ Exp $

MODULE_AUTHOR="DANBORN"
inherit perl-module

DESCRIPTION="Query a Google SafeBrowsing table"

IUSE="test"

SLOT="0"
LICENSE="Apache-2.0"
KEYWORDS="~amd64 ~x86 ~ppc"
RDEPEND="dev-perl/URI
		 >=perl-core/Math-BigInt-1.87
		 || (
			dev-perl/Math-BigInt-FastCalc
			dev-perl/Math-BigInt-GMP
			)"
DEPEND="${RDEPEND}
		test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
