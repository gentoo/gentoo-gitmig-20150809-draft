# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/centericq/centericq-4.7.7-r1.ebuild,v 1.1 2002/07/12 01:04:48 lostlogic Exp $

S=${WORKDIR}/${P}
DESCRIPTION="A ncurses ICQ/Yahoo!/MSN Client"
SRC_URI="http://konst.org.ua/download/${P}.tar.gz"
HOMEPAGE="http://konst.org.ua/eng/software/centericq/info.html"
SLOT="0"
LICENSE="GPL-2"
DEPEND="virtual/glibc
	>=sys-libs/ncurses-5.2
	nls? ( sys-devel/gettext )
	( >=dev-libs/libsigc++-1.0.4-r1
	  <dev-libs/libsigc++-1.1.0 )"
RDEPEND="${DEPEND}"

src_compile() {
	local myopts=""

	use nls || myopts="--disable-nls"
	
	./configure --prefix=/usr \
		--host=${CHOST} \
		--with-included-gettext \
		${myopts} || die "Configure failed"
	
	emake || die "Compilation failed"
}

src_install () {
	make DESTDIR=${D} install || die "Installation failed"

	dodoc ABOUT-NLS AUTHORS ChangeLog COPYING FAQ README THANKS TODO
}
