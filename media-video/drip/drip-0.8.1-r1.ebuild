# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer:  Martin Schlemmer <azarah@cvs.gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/drip/drip-0.8.1-r1.ebuild,v 1.2 2002/05/19 10:20:41 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Drip - A DVD to DIVX convertor frontend"
SRC_URI="${SRC_URI} http://drip.sourceforge.net/files/${P}.tar.gz"
HOMEPAGE="http://drip.sourceforge.net/"

RDEPEND="gnome-base/gnome-libs
	=media-video/avifile-0.6.0*
	media-libs/libdvdcss
	media-libs/libdvdread
	media-libs/gdk-pixbuf"
	
DEPEND="${RDEPEND}
	dev-lang/nasm
	>=sys-devel/automake-1.5-r1"


src_unpack() {

	unpack ${A}

	cd ${S}
	cp encoder/plugin-loader.cpp encoder/plugin-loader.cpp.orig
	sed -e "s:/usr/local/lib:/usr/lib:g" \
		encoder/plugin-loader.cpp.orig >encoder/plugin-loader.cpp
}

src_compile() {

	libtoolize --copy --force

	local myconf
	use nls || myconf="--disable-nls"

	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--localstatedir=/var/lib \
		--sysconfdir=/etc \
		$myconf || die
			
	emake || die
}

src_install() {
	
	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		localstatedir=${D}/var/lib \
		sysconfdir=${D}/etc \
		drip_helpdir=${D}/usr/share/gnome/help/drip/C \
		drip_pixmapdir=${D}/usr/share/pixmaps \
		install || die

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO

	insinto /usr/share/pixmaps
	newins ${S}/pixmaps/drip_logo.jpg drip.jpg
	insinto /usr/share/gnome/apps/Multimedia
	doins ${FILESDIR}/drip.desktop
}

