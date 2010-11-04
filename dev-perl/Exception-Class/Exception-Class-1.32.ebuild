# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Exception-Class/Exception-Class-1.32.ebuild,v 1.2 2010/11/04 13:22:08 fauli Exp $

EAPI=3

MODULE_AUTHOR=DROLSKY
inherit perl-module

DESCRIPTION="A module that allows you to declare real exception classes in Perl"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~sparc x86 ~amd64-linux ~ia64-linux ~x86-linux ~ppc-macos"
IUSE=""

RDEPEND=">=dev-perl/Class-Data-Inheritable-0.02
	>=dev-perl/Devel-StackTrace-1.20"
DEPEND="${RDEPEND}
	>=virtual/perl-ExtUtils-MakeMaker-6.31"

SRC_TEST="do"
