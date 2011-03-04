# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Class-MethodMaker/Class-MethodMaker-2.170.0.ebuild,v 1.1 2011/03/04 07:49:17 tove Exp $

EAPI=3

MODULE_AUTHOR=SCHWIGON
MODULE_SECTION=class-methodmaker
MODULE_VERSION=2.17
inherit perl-module eutils

DESCRIPTION="Create generic methods for OO Perl"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~x86-fbsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~x86-solaris"
IUSE=""

SRC_TEST="do"
