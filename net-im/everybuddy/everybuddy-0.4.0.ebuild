# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-im/everybuddy/everybuddy-0.4.0.ebuild,v 1.8 2003/09/05 23:58:57 msterret Exp $

IUSE="arts esd gnome"

S=${WORKDIR}/${P}
DESCRIPTION="Universal Instant Messaging Client"
SRC_URI="http://www.everybuddy.com/files/${P}.tar.gz"
HOMEPAGE="http://www.everybuddy.com/"
DEPEND="=x11-libs/gtk+-1.2*
	arts? ( >=kde-base/arts-1.0.0 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.4 )
	esd? ( >=media-sound/esound-0.2.24 )"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc"

src_compile() {
	local myconf
	use arts	\
		&& myconf="--enable-arts"	\
		|| myconf="--disable-arts"

	use esd 	\
		&& myconf="${myconf} --enable-esd"	\
		|| myconf="${myconf} --disable-esd"

	use gnome 	\
		&& myconf="${myconf} --with-gnome"	\
		|| myconf="${myconf} --without-gnome"

	echo ${myconf}

	./configure 	\
		--prefix=/usr 	\
		--mandir=/usr/share/man 	\
		--host=${CHOST} 	\
		${myconf} || die
	make || die

}

src_install () {
	make 	\
		DESTDIR=${D}	\
		install || die

	dodoc AUTHORS NEWS README TODO COPYING ChangeLog
}
