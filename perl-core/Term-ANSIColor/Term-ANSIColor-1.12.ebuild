# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/perl-core/Term-ANSIColor/Term-ANSIColor-1.12.ebuild,v 1.2 2009/12/16 21:57:27 abcd Exp $

MY_PN="ANSIColor"
MY_P="$MY_PN-$PV"
S="${WORKDIR}/$MY_P"
MODULE_AUTHOR=RRA
inherit perl-module

DESCRIPTION="Color screen output using ANSI escape sequences."

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="alpha amd64 hppa ia64 ppc sparc x86 ~x86-fbsd ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"
IUSE="test"
SRC_TEST="do"

RDEPEND="dev-lang/perl"
DEPEND="${RDEPEND}
	test? ( dev-perl/Test-Pod )"
