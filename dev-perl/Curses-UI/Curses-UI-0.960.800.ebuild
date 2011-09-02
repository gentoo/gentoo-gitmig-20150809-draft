# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Curses-UI/Curses-UI-0.960.800.ebuild,v 1.1 2011/09/02 19:00:45 tove Exp $

MODULE_AUTHOR=MDXI
MODULE_VERSION=0.9608
inherit perl-module

DESCRIPTION="Perl UI framework based on the curses library."
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Curses
	dev-perl/Test-Pod
	dev-perl/TermReadKey
	dev-lang/perl"
