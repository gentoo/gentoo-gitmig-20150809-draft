# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mime-construct/mime-construct-1.9-r1.ebuild,v 1.9 2010/02/06 14:37:18 tove Exp $

EAPI=2

MODULE_AUTHOR=ROSCH
inherit perl-module

DESCRIPTION="construct and optionally mail MIME messages"

LICENSE="|| ( GPL-2 GPL-3 )" # GPL-2+
SLOT="0"
KEYWORDS="amd64 ia64 x86"
IUSE=""

RDEPEND="dev-perl/MIME-Types
	dev-perl/Proc-WaitStat"
DEPEND="${RDEPEND}"

SRC_TEST="do"
