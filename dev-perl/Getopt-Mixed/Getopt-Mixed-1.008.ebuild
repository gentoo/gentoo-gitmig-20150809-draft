# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header $

IUSE=""

inherit perl-module

S="${WORKDIR}/${P}"
CATEGORY="dev-perl"

DESCRIPTION="Getopt::Mixed is used for parsing mixed options"
SRC_URI="http://www.cpan.org/modules/by-module/Getopt/${P}.tar.gz"
HOMEPAGE="http://www.cpan.org/modules/by-module/Getopt/${P}.readme"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ppc ~sparc ~sparc64 ~alpha"

DEPEND="${DEPEND}"
