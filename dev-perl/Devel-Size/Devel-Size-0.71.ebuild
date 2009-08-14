# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Size/Devel-Size-0.71.ebuild,v 1.3 2009/08/14 18:28:10 maekke Exp $

MODULE_AUTHOR=TELS
MODULE_SECTION=devel
inherit perl-module

DESCRIPTION="Perl extension for finding the memory usage of Perl variables"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ia64 ~ppc64 ~sparc x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
