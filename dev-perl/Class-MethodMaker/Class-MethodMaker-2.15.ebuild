# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MethodMaker/Class-MethodMaker-2.15.ebuild,v 1.5 2009/09/18 23:10:49 maekke Exp $

MODULE_AUTHOR=SCHWIGON
MODULE_SECTION=class-methodmaker
inherit perl-module eutils

DESCRIPTION="Perl module for Class::MethodMaker"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha amd64 arm hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~x86-fbsd"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
