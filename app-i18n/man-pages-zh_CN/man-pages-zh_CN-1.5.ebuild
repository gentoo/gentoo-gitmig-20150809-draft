# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/man-pages-zh_CN/man-pages-zh_CN-1.5.ebuild,v 1.1 2005/09/02 04:26:59 vapier Exp $

DESCRIPTION="A somewhat comprehensive collection of Chinese Linux man pages"
HOMEPAGE="http://cmpp.linuxforum.net/"
SRC_URI="http://download.sf.linuxforum.net/cmpp/${P}.tar.gz"

LICENSE="FDL-1.2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k mips ppc ppc64 s390 sh sparc x86"
IUSE=""

RDEPEND="sys-apps/man"

src_unpack() {
	unpack ${A}
	cd "${S}"
	rm -r `find . -type d -name CVS`
}

src_compile() {
	make u8 || die
}

src_install() {
	make install-u8 DESTDIR="${D}"/usr/share || die
	dodoc README* DOCS/*
}
