# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/aspell-da/aspell-da-1.4.27.ebuild,v 1.1 2003/10/29 01:59:31 seemant Exp $

ASPELL_LANG="Danish"
inherit aspell-dict

HOMEPAGE="http://da.spelling.org"
SRC_URI="http://da.speling.org/filer/${P}.tar.gz"

LICENSE="GPL-2"

S=${WORKDIR}/${P}

src_compile() {
	emake || die
}

src_install() {
	insinto /usr/share/aspell
	doins *.dat

	insinto /usr/lib/aspell
	doins dansk

	dodoc COPYING Copyright README contributors
}
