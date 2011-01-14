# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Curses-UI/Curses-UI-0.960.700.ebuild,v 1.1 2011/01/14 11:47:26 tove Exp $

MODULE_AUTHOR=MDXI
MODULE_VERSION=0.9607
inherit perl-module

DESCRIPTION="Perl UI framework based on the curses library."
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 hppa ia64 ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Curses
	dev-perl/Test-Pod
	dev-perl/TermReadKey
	dev-lang/perl"
