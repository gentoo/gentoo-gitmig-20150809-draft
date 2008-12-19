# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-Run/IPC-Run-0.82.ebuild,v 1.1 2008/12/19 16:40:51 tove Exp $

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="system() and background procs w/ piping, redirs, ptys"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/IO-Tty-1.0
	dev-lang/perl"

SRC_TEST=do
