# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/linklint/linklint-2.3.4.ebuild,v 1.4 2004/07/14 06:16:24 mr_bones_ Exp $

DESCRIPTION="Linklint is a Perl program that checks links on web sites."
HOMEPAGE="http://www.mindspring.com/~bowlin/linklint/index.html"
SRC_URI="http://www.mindspring.com/~bowlin/linklint/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE=""

DEPEND="dev-lang/perl"

src_install() {
	exeinto /usr/bin
	newexe ${P} linklint
	dodoc INSTALL.unix INSTALL.windows LICENSE.txt READ_ME.txt CHANGES.txt
	dohtml doc/*
}
