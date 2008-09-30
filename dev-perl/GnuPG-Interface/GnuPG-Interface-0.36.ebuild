# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/GnuPG-Interface/GnuPG-Interface-0.36.ebuild,v 1.6 2008/09/30 13:22:56 tove Exp $

MODULE_AUTHOR=JESSE
inherit perl-module

DESCRIPTION="GnuPG::Interface is a Perl module interface to interacting with GnuPG."

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86"
IUSE=""
DEPEND=">=app-crypt/gnupg-1.2.1-r1
	>=dev-perl/Class-MethodMaker-1.11
	dev-lang/perl"

SRC_TEST="do"
