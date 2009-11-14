# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Gearman-Client-Async/Gearman-Client-Async-0.94.ebuild,v 1.2 2009/11/14 11:14:06 robbat2 Exp $

MODULE_AUTHOR=DORMANDO
inherit perl-module

DESCRIPTION="Asynchronous client module for Gearman for Danga::Socket applications"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND=">=dev-perl/Gearman-1.07
		>=dev-perl/Danga-Socket-1.57
		dev-lang/perl"

mydoc="CHANGES README.txt TODO"
# testsuite requires gearman server
SRC_TEST="never"
