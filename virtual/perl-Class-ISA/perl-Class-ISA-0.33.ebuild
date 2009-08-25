# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Class-ISA/perl-Class-ISA-0.33.ebuild,v 1.3 2009/08/25 10:56:56 tove Exp $

DESCRIPTION="Report the search path thru an ISA tree"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ia64 ppc ppc64 sparc x86"

IUSE=""
DEPEND=""

RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~dev-lang/perl-5.10.0 ~perl-core/Class-ISA-${PV} )"
