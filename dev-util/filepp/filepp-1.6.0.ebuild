# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/filepp/filepp-1.6.0.ebuild,v 1.2 2003/02/13 11:52:13 vapier Exp $

DESCRIPTION="Generic file-preprocessor with a CPP-like syntax"
HOMEPAGE="http://www.cabaret.demon.co.uk/filepp/"
SRC_URI="http://www.cabaret.demon.co.uk/filepp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"

RDEPEND="sys-devel/perl"

moduledir="/usr/share/${P}/modules"
src_compile() {
	econf --with-moduledir=${moduledir}
}

src_install() {
	einstall moduledir=${D}/${moduledir}
	dodoc ChangeLog README
	dohtml filepp.html
}
