# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/virtual/perl-Module-Load-Conditional/perl-Module-Load-Conditional-0.30.ebuild,v 1.3 2009/08/25 10:56:46 tove Exp $

DESCRIPTION="Looking up module information / loading at runtime"
HOMEPAGE="http://www.gentoo.org/proj/en/perl/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="|| ( ~dev-lang/perl-5.10.1 ~perl-core/Module-Load-Conditional-${PV} )"
