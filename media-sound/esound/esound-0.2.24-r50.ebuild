# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Achim Gottinger <achim@gentoo.org> and Spider <spider@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/esound/esound-0.2.24-r50.ebuild,v 1.2 2002/04/11 00:34:52 spider Exp $

EXTRA="esound-0.2.24-ztp20020319_0.patch.gz"
S=${WORKDIR}/${P}
DESCRIPTION="The Enlightened Sound Daemon"
SRC_URI="ftp://ftp.gnome.org/pub/GNOME/stable/sources/esound/${P}.tar.gz ftp://download.sourceforge.net/pub/mirrors/gnome/stable/sources/esound/${P}.tar.gz 
http://webpages.charter.net/tprado/esound/files/${EXTRA}"

HOMEPAGE="http://www.tux.org/~ricdude/EsounD.html"

DEPEND="virtual/glibc
	>=media-libs/audiofile-0.1.9
	alsa? ( media-libs/alsa-lib )
    tcpd? ( >=sys-apps/tcp-wrappers-7.6-r2 )"

RDEPEND="virtual/glibc
	>=media-libs/audiofile-0.1.9
	alsa? ( media-libs/alsa-lib )"

src_unpack() {
	unpack ${P}.tar.gz
	cd ${S}
	gunzip -dc ${DISTDIR}/${EXTRA} | patch -p1 - 
}
			

src_compile() {
	libtoolize --copy --force	
	local myconf

	use tcpd && myconf="${myconf} --with-libwrap" \
		|| myconf="${myconf} --without-libwrap"

	use alsa && myconf="${myconf} --enable-alsa" \
		|| myconf="${myconf} --enable-alsa=no"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--sysconfdir=/etc/esd \
		${myconf} || die

	make || die
}

src_install() {                               
	make prefix=${D}/usr sysconfdir=${D}/etc/esd install || die

	dodoc AUTHORS COPYING* ChangeLog README TODO NEWS TIPS
	dodoc docs/esound.ps

	dohtml docs/html/*.html

}


