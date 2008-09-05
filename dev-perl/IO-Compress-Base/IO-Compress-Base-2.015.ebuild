# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IO-Compress-Base/IO-Compress-Base-2.015.ebuild,v 1.1 2008/09/05 08:21:31 tove Exp $

MODULE_AUTHOR=PMQS

inherit perl-module

DESCRIPTION="Base Class for IO::Compress modules"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE="test"

RDEPEND="virtual/perl-Scalar-List-Utils
	dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"

SRC_TEST="do"
