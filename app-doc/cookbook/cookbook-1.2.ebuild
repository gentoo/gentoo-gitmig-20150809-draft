# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/cookbook/cookbook-1.2.ebuild,v 1.3 2004/04/01 12:22:57 dholm Exp $

DESCRIPTION="The Linux Cookbook by Michael Stutz"
HOMEPAGE="http://www.dsl.org/cookbook/"
SRC_URI="http://www.dsl.org/cookbook/${P}.tar.gz"

LICENSE="DSL"
SLOT="0"
KEYWORDS="x86 ~ppc"

src_install() {
	dodoc *.txt
	doinfo info/*
}
