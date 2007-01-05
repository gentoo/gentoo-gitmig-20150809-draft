# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/lua-wrapper/lua-wrapper-1.ebuild,v 1.1 2007/01/05 18:13:15 mabi Exp $

DESCRIPTION="A small shell script to choose the enable different lua versions"
HOMEPAGE="http://dev.gentoo.org/~mabi/lua-wrapper/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc"
IUSE=""

DEPEND=""
RDEPEND=""

src_install () {
	exeinto /usr/bin
	newexe ${FILESDIR}/${P}.sh lua-config || die "Install failed"
}
