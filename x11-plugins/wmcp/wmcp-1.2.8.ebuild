# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/wmcp/wmcp-1.2.8.ebuild,v 1.7 2004/03/26 23:10:07 aliz Exp $

inherit eutils

IUSE=""
DESCRIPTION="A pager dockapp"
HOMEPAGE="http://www.dockapps.com/file.php/id/158"
SRC_URI="http://linux-sea.tucows.webusenet.com/files/x11/dock/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 amd64 ~ia64 ~ppc ~sparc ~alpha ~hppa ~mips"

DEPEND="virtual/glibc
	virtual/x11"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${FILESDIR}/${P}-makefile.patch
	epatch ${FILESDIR}/${P}-gcc33.patch
}

src_compile() {
	make || die "make failed"
}

src_install() {
	cd ${S}
	dobin wmcp
	dodoc README
}
