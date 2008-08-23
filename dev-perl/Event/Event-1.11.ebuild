# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Event/Event-1.11.ebuild,v 1.1 2008/08/23 19:55:03 tove Exp $

MODULE_AUTHOR=JPRIT
inherit perl-module

DESCRIPTION="fast, generic event loop"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""
SRC_TEST="do"

mydoc="ANNOUNCE INSTALL TODO Tutorial.pdf"

DEPEND="dev-lang/perl"
