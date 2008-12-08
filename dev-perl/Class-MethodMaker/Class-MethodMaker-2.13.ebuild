# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MethodMaker/Class-MethodMaker-2.13.ebuild,v 1.1 2008/12/08 02:05:57 robbat2 Exp $

MODULE_AUTHOR=SCHWIGON
MODULE_SECTION=class-methodmaker
inherit perl-module eutils

DESCRIPTION="Perl module for Class::MethodMaker"

LICENSE="Artistic"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd"
IUSE=""

SRC_TEST="do"

RDEPEND="dev-lang/perl"
