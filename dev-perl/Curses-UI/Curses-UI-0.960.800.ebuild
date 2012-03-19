# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Curses-UI/Curses-UI-0.960.800.ebuild,v 1.2 2012/03/19 19:35:21 armin76 Exp $

MODULE_AUTHOR=MDXI
MODULE_VERSION=0.9608
inherit perl-module

DESCRIPTION="Perl UI framework based on the curses library."
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Curses
	dev-perl/Test-Pod
	dev-perl/TermReadKey
	dev-lang/perl"
