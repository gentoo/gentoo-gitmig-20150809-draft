# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/filepp/filepp-1.6.0.ebuild,v 1.5 2004/04/16 20:16:35 randy Exp $

DESCRIPTION="Generic file-preprocessor with a CPP-like syntax"
HOMEPAGE="http://www.cabaret.demon.co.uk/filepp/"
SRC_URI="http://www.cabaret.demon.co.uk/filepp/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 s390"

RDEPEND="dev-lang/perl"

moduledir="/usr/share/${P}/modules"
src_compile() {
	econf --with-moduledir=${moduledir}
}

src_install() {
	einstall moduledir=${D}/${moduledir}
	dodoc ChangeLog README
	dohtml filepp.html
}
