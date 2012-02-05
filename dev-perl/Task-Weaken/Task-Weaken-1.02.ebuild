# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Task-Weaken/Task-Weaken-1.02.ebuild,v 1.4 2012/02/05 17:37:06 armin76 Exp $

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="Ensure that a platform has weaken support "

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
