# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/dev-util/david/david-0.99.2.ebuild,v 1.2 2002/05/23 06:50:12 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="The C/C++ Code editor for Gnome"
SRC_URI="http://david.es.gnome.org/downloads/${P}.tar.gz"
HOMEPAGE="http://david.es.gnome.org"
SLOT="0"

DEPEND="virtual/glibc
	>=dev-libs/libxml-1.8.16
	=x11-libs/gtk+-1.2*
	>=gnome-base/gnome-libs-1.4.1.5
	>=media-libs/audiofile-0.2.3
	>=media-sound/esound-0.2.23
	=dev-libs/glib-1.2*
	nls? ( sys-devel/gettext )"

src_compile() {
        local myconf=""

        use nls || myconf="${myconf} --disable-nls"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man \
		${myconf} || die "./configure failed"

	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die "installation failed"


	#make \
	#	prefix=${D}/usr \
	#	mandir=${D}/usr/share/man \
	#	infodir=${D}/usr/share/info \
	#	install || die

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO
}
