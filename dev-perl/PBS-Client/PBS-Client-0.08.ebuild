# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/PBS-Client/PBS-Client-0.08.ebuild,v 1.1 2010/03/10 06:25:59 tove Exp $

EAPI=2

MODULE_SECTION=${PN/-//}
MODULE_AUTHOR=KWMAK
inherit perl-module

DESCRIPTION="Perl interface to submit jobs to PBS (Portable Batch System)"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

SRC_TEST="do"
