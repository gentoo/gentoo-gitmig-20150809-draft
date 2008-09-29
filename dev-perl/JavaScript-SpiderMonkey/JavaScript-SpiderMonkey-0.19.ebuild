# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/JavaScript-SpiderMonkey/JavaScript-SpiderMonkey-0.19.ebuild,v 1.1 2008/09/29 01:52:55 robbat2 Exp $

MODULE_AUTHOR="TBUSCH"

inherit perl-module

DESCRIPTION="Perl interface to the JavaScript Engine"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-perl/Log-Log4perl
		>=dev-lang/spidermonkey-1.5"
