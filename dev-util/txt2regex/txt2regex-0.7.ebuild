# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/txt2regex/txt2regex-0.7.ebuild,v 1.3 2004/05/24 20:54:42 ciaranm Exp $

DESCRIPTION="A Regular Expression wizard that converts human sentences to regexs"
SRC_URI="http://txt2regex.sourceforge.net/${P}.tgz"
HOMEPAGE="http://txt2regex.sourceforge.net/"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~mips"

RDEPEND=">=app-shells/bash-2.04"

src_install() {
	einstall DESTDIR=${D} MANDIR=${D}/usr/share/man/man1 || die
	dodoc Changelog COPYRIGHT NEWS README README.japanese TODO
	newman txt2regex.man txt2regex.6
}

