# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MethodMaker/Class-MethodMaker-2.15.ebuild,v 1.11 2010/01/09 17:32:44 grobian Exp $

MODULE_AUTHOR=SCHWIGON
MODULE_SECTION=class-methodmaker
inherit perl-module eutils

DESCRIPTION="Perl module for Class::MethodMaker"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
