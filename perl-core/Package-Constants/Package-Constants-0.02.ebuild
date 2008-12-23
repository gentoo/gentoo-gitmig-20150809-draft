# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Package-Constants/Package-Constants-0.02.ebuild,v 1.1 2008/12/23 08:48:00 robbat2 Exp $

MODULE_AUTHOR=KANE
inherit perl-module

DESCRIPTION="List all constants declared in a package"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST=do
