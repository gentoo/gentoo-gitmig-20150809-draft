# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Danga-Socket/Danga-Socket-1.61.ebuild,v 1.3 2011/09/04 10:12:43 maekke Exp $

MODULE_AUTHOR="BRADFITZ"
inherit perl-module

DESCRIPTION="A non-blocking socket object; uses epoll()"

IUSE=""

SLOT="0"
LICENSE="|| ( Artistic GPL-2 )"
KEYWORDS="amd64 ~ppc x86"

DEPEND="dev-perl/Sys-Syscall
		dev-lang/perl"
mydoc="CHANGES"
SRC_TEST="do"
