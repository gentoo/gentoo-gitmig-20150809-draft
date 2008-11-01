# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Class-ISA/perl-Class-ISA-0.33.ebuild,v 1.1 2008/11/01 18:45:57 yuval Exp $

DESCRIPTION="Report the search path thru an ISA tree"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"

IUSE=""
DEPEND=""

RDEPEND="|| ( ~dev-lang/perl-5.10.0 ~perl-core/Class-ISA-${PV} )"

