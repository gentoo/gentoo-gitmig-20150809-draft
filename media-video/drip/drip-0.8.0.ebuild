# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer:  Martin Schlemmer <azarah@cvs.gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/drip/drip-0.8.0.ebuild,v 1.1 2001/12/31 23:46:18 azarah Exp $

# Drip needs automake-1.5 exactly
AMAKEVER=1.5b
ACONFVER=2.52

. /usr/portage/eclass/inherit.eclass || die
inherit autotools || die

S=${WORKDIR}/${P}
DESCRIPTION="Drip - A DVD to DIVX convertor frontend"
SRC_URI="${SRC_URI} http://drip.sourceforge.net/files/${P}.tar.gz"
HOMEPAGE="http://drip.sourceforge.net/"

RDEPEND="gnome-base/gnome-libs
	>=media-video/avifile-0.6
	media-libs/libdvdcss
	media-libs/libdvdread
	media-libs/gdk-pixbuf"
	
DEPEND="${DEPEND}
	${RDEPEND}
	dev-lang/nasm"


src_unpack() {

	unpack ${A}

	cd ${S}
	patch < ${FILESDIR}/drip-0.8.0-automake.diff || die
}

src_compile() {

	install_autotools
        
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

