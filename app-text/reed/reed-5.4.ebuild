# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/reed/reed-5.4.ebuild,v 1.1 2003/10/01 20:42:32 pyrania Exp $


DESCRIPTION="This is a text pager (text file viewer), used to display etexts."
HOMEPAGE="http://www.sacredchao.net/software/reed/index.shtml"
SRC_URI=http://www.sacredchao.net/software/reed/${P}.tar.gz
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""


src_compile() {
	./configures --prefix=/usr || die
	make || die
}

src_install() {
	make DESTDIR=${D} install || die
}

