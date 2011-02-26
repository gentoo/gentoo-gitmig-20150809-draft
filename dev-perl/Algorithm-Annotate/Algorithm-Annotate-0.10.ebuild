# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Algorithm-Annotate/Algorithm-Annotate-0.10.ebuild,v 1.18 2011/02/26 08:41:43 tove Exp $

EAPI=3

MODULE_AUTHOR=CLKAO
inherit perl-module

DESCRIPTION="Represent a series of changes in annotate form"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~sparc-solaris"
IUSE=""

RDEPEND=">=dev-perl/Algorithm-Diff-1.150.0"
DEPEND="${RDEPEND}"

SRC_TEST="do"
