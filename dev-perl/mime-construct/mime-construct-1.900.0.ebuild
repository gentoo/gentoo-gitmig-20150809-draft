# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/mime-construct/mime-construct-1.900.0.ebuild,v 1.2 2011/09/03 21:04:28 tove Exp $

EAPI=4

MODULE_AUTHOR=ROSCH
MODULE_VERSION=1.9
inherit perl-module

DESCRIPTION="construct and optionally mail MIME messages"

LICENSE="|| ( GPL-2 GPL-3 )" # GPL-2+
SLOT="0"
KEYWORDS="amd64 ia64 ~ppc x86"
IUSE=""

RDEPEND="dev-perl/MIME-Types
	dev-perl/Proc-WaitStat"
DEPEND="${RDEPEND}"

SRC_TEST="do"
