# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-Run/IPC-Run-0.86.ebuild,v 1.1 2010/03/26 12:35:53 tove Exp $

EAPI=2

MODULE_AUTHOR=TODDR
inherit perl-module

DESCRIPTION="system() and background procs w/ piping, redirs, ptys"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/IO-Tty-1.08"
RDEPEND="${DEPEND}"

SRC_TEST=do
