# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Algorithm-Diff/Algorithm-Diff-1.1902.ebuild,v 1.9 2010/10/25 10:08:52 jer Exp $

MODULE_AUTHOR=TYEMQ
inherit perl-module

DESCRIPTION="Compute intelligent differences between two files / lists"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ia64 ppc ppc64 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

DEPEND="dev-lang/perl"

SRC_TEST="do"
