# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Danga-Socket/Danga-Socket-1.59.ebuild,v 1.1 2008/07/29 19:49:26 robbat2 Exp $

MODULE_AUTHOR="MSERGEANT"
inherit perl-module

DESCRIPTION="A non-blocking socket object; uses epoll()"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="dev-perl/Sys-Syscall
		dev-lang/perl"
mydoc="CHANGES"
SRC_TEST="do"
