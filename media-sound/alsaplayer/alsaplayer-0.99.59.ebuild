# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author: Seemant Kulleen <seemant@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/alsaplayer/alsaplayer-0.99.59.ebuild,v 1.1 2002/04/26 19:33:14 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Media player primarily utilising ALSA"
SRC_URI="http://www.alsaplayer.org/${P}.tar.bz2"
HOMEPAGE="http://www.alsa-project.org/"
QTROOT="/usr/qt/3"

DEPEND=">=media-libs/alsa-lib-0.5.10
	qt? ( >=x11-libs/qt-3.0.1 )
	esd? ( media-sound/esound )
	gtk? ( x11-libs/gtk+ )
	oggvorbis? ( media-libs/libvorbis )
	>=media-libs/libmikmod-3.1.10
	>=dev-libs/glib-1.2.10"
	

src_compile() {

	local myconf

	use oggvorbis \
		|| myconf="--enable-vorbis=no"

	use oss \
		|| myconf="${myconf} --enable-oss=no"

	use esd \
		&& myconf="${myconf} --enable-audiofile=yes" \
		|| myconf="${myconf} --enable-esd=no"

	use nas \
		&& myconf="${myconf} --enable-nas=yes"

	use gtk \
		|| myconf="${myconf} --enable-gtk=no"

	use qt \
		&& myconf="${myconf} --enable-qt=yes \
				--with-qt-libdir=${QTROOT}/lib \
				--with-qt-indir=${QTROOT}/include \
				--with-qt-bindir=${QTROOT}/bin"

	econf ${myconf} || die

	emake || die
}

src_install() {

	make \
		prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		install || die

	dodoc AUTHORS COPYING ChangeLog README TODO
	dodoc docs/sockmon.txt docs/wishlist.txt
}
