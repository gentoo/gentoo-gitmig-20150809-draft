# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/dev-util/dialog/dialog-0.9_beta20020519.ebuild,v 1.4 2002/07/23 10:38:07 seemant Exp $

MY_PV="0.9b-20020519"
S=${WORKDIR}/dialog-${MY_PV}
DESCRIPTION="A Tool to display Dialog boxes from Shell"
SRC_URI="ftp://ftp.debian.org/debian/pool/main/d/dialog/dialog_${MY_PV}.orig.tar.gz"
HOMEPAGE="http://www.advancedresearch.org/dialog/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-apps/bash-2.04-r3
	>=sys-libs/ncurses-5.2-r5"

src_compile() {
	econf --with-ncurses || die
}

src_install() {
	make DESTDIR=${D} MANDIR=${D}/usr/share/man/man1 install || die

	dodoc CHANGES COPYING README VERSION
}
