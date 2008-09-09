# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Schedule-At/Schedule-At-1.07.ebuild,v 1.1 2008/09/09 08:55:04 tove Exp $

MODULE_AUTHOR=JOSERODR
inherit perl-module

DESCRIPTION="OS independent interface to the Unix 'at' command"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

#SRC_TEST="do"

DEPEND="sys-process/at
	dev-lang/perl"
