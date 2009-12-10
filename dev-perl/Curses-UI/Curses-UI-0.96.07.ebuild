# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Curses-UI/Curses-UI-0.96.07.ebuild,v 1.5 2009/12/10 20:56:53 ranger Exp $

inherit versionator
MY_P=${PN}-$(delete_version_separator 2)
S=${WORKDIR}/${MY_P}
MODULE_AUTHOR=MDXI
inherit perl-module

DESCRIPTION="Perl UI framework based on the curses library."
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="amd64 ~hppa ~ia64 ~ppc ppc64 sparc x86"
IUSE=""

SRC_TEST="do"

DEPEND="dev-perl/Curses
	dev-perl/Test-Pod
	dev-perl/TermReadKey
	dev-lang/perl"
