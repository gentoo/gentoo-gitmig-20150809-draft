# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Algorithm-Annotate/Algorithm-Annotate-0.10.ebuild,v 1.17 2010/01/28 17:36:40 tove Exp $

MODULE_AUTHOR=CLKAO
inherit perl-module

DESCRIPTION="Algorithm::Annotate - represent a series of changes in annotate form"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

DEPEND=">=dev-perl/Algorithm-Diff-1.15
	dev-lang/perl"

SRC_TEST="do"
