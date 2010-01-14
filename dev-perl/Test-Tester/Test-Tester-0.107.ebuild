# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Test-Tester/Test-Tester-0.107.ebuild,v 1.13 2010/01/14 15:04:37 grobian Exp $

MODULE_AUTHOR=FDALY
inherit perl-module

DESCRIPTION="Ease testing test modules built with Test::Builder"

SLOT="0"
LICENSE="Artistic"
KEYWORDS="alpha amd64 arm hppa ia64 ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
