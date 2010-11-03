# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Socket6/Socket6-0.20.ebuild,v 1.5 2010/11/03 18:52:44 pva Exp $

MODULE_AUTHOR=UMEMOTO
inherit perl-module

DESCRIPTION="IPv6 related part of the C socket.h defines and structure manipulators"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ~ppc ~ppc64 s390 sh sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-lang/perl"
