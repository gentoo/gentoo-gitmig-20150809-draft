# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-doc/cookbook/cookbook-1.2.ebuild,v 1.1 2004/02/21 08:35:43 vapier Exp $

DESCRIPTION="The Linux Cookbook by Michael Stutz"
HOMEPAGE="http://www.dsl.org/cookbook/"
SRC_URI="http://www.dsl.org/cookbook/${P}.tar.gz"

LICENSE="DSL"
SLOT="0"
KEYWORDS="x86"

src_install() {
	dodoc *.txt
	doinfo info/*
}
