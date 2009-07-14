# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/IPC-Run/IPC-Run-0.84.ebuild,v 1.1 2009/07/14 16:34:06 tove Exp $

EAPI=2

MODULE_AUTHOR=ADAMK
inherit perl-module

DESCRIPTION="system() and background procs w/ piping, redirs, ptys"

SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE=""

DEPEND=">=dev-perl/IO-Tty-1.08"
RDEPEND="${DEPEND}"

SRC_TEST=do
