# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/parted/parted-1.4.24-r3.ebuild,v 1.4 2002/07/14 19:20:18 aliz Exp $

S=${WORKDIR}/${P}
DESCRIPTION="An advanced partition modification system"
SRC_URI="ftp://ftp.gnu.org/gnu/${PN}/${P}.tar.gz
	ftp://gatekeeper.dec.com/pub/GNU/${PN}/${P}.tar.gz"
HOMEPAGE="http://www.gnu.org/software/parted"
KEYWORDS="x86"
SLOT="0"
LICENSE="GPL-2"

DEPEND=">=sys-apps/e2fsprogs-1.27
	>=sys-libs/ncurses-5.2-r5
	readline? ( >=sys-libs/readline-4.1-r4 )"

RDEPEND="nls? ( sys-devel/gettext )"


src_compile() {
	local myconf

	use readline	\
		&& myconf="${myconf} --with-readline"	\
		|| myconf="${myconf} --without-readline"

	use nls 	\
		&& myconf="${myconf} --enable-nls"	\
		|| myconf="${myconf} --disable-nls"

	./configure --prefix=/usr \
		--target=${CHOST} \
		--mandir=/usr/share/man \
		${myconf} || die
		
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die
	
	if [ -z "`use bootcd`" ]
	then
		dodoc ABOUT-NLS AUTHORS BUGS COPYING ChangeLog INSTALL NEWS \
			README THANKS TODO 
		cd doc ; docinto doc
		dodoc API COPYING.DOC FAQ FAT USER USER.jp
	else
		rm -rf ${D}/usr/share ${D}/usr/include ${D}/usr/lib/lib*.{a,la}
	fi
}
