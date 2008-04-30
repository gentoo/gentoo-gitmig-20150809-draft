# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/ExtUtils-CBuilder/ExtUtils-CBuilder-0.23.ebuild,v 1.1 2008/04/30 11:28:01 tove Exp $

MODULE_AUTHOR=KWILLIAMS

inherit perl-module

DESCRIPTION="Compile and link C code for Perl modules"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~sparc-fbsd ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	dev-perl/module-build"

SRC_TEST="do"
