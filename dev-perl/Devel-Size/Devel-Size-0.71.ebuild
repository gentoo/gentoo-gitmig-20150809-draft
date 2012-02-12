# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Devel-Size/Devel-Size-0.71.ebuild,v 1.6 2012/02/12 15:13:37 armin76 Exp $

MODULE_AUTHOR=TELS
MODULE_SECTION=devel
inherit perl-module

DESCRIPTION="Perl extension for finding the memory usage of Perl variables"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~ppc64 x86"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
