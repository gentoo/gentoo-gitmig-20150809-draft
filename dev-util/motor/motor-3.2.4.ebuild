# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/motor/motor-3.2.4.ebuild,v 1.1 2003/04/10 20:25:44 liquidx Exp $

IUSE="nls"

S=${WORKDIR}/${P}
DESCRIPTION="Motor is a text mode based programming environment for Linux"
HOMEPAGE="http://konst.org.ua/motor/"
SRC_URI="http://konst.org.ua/download/${P}.tar.bz2"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf
	use nls || myconf="--disable-nls"

	./configure \
		--host=${CHOST} \
		--prefix="/usr" \
		--infodir="/usr/share/info" \
		--mandir="/usr/share/man" \
		${myconf} || die "./configure failed"
	emake || die
}

src_install() {
	einstall || die
	 
	dodoc AUTHORS COPYING README TODO FAQ ChangeLog
	docinto tutorial
	dohtml -r tutorial/*
	 
}
