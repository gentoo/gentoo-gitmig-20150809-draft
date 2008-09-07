# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Size/Devel-Size-0.71.ebuild,v 1.1 2008/09/07 06:58:07 tove Exp $

MODULE_AUTHOR=TELS
MODULE_SECTION=devel
inherit perl-module

DESCRIPTION="Perl extension for finding the memory usage of Perl variables"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~sparc ~x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
