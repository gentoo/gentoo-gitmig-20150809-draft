# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Getopt-Long/Getopt-Long-2.37.ebuild,v 1.1 2008/09/10 11:56:14 tove Exp $

MODULE_AUTHOR=JV
inherit perl-module

DESCRIPTION="Advanced handling of command line options"

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND="virtual/perl-PodParser
		dev-lang/perl"

SRC_TEST=do
