# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.7-r4.ebuild,v 1.2 2002/03/28 23:03:44 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="X MultiMedia System"
SRC_URI="ftp://ftp.xmms.org/xmms/1.2.x/${P}.tar.gz http://www.openface.ca/~nephtes/plover-xmms127.tar.gz"
HOMEPAGE="http://www.xmms.org/"

RDEPEND="gnome? ( >=gnome-base/gnome-core-1.4.0.4-r1 )
	>=dev-libs/libxml-1.8.15
	>=media-libs/libmikmod-3.1.9
	esd? ( >=media-sound/esound-0.2.22 )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	opengl? ( virtual/opengl )
	avi? ( >=media-video/avifile-0.6 )
	>=x11-libs/gtk+-1.2.10-r4"

DEPEND="${RDEPEND}
	nls? ( dev-util/intltool )"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	
	if [ "`use avi`" ]
	then
		cp xmms/Makefile.am xmms/Makefile.am.orig
		sed -e "s:\(@INTLLIBS@\):\1 -laviplay -lstdc++:" \
			xmms/Makefile.am.orig > xmms/Makefile.am
	fi
}

src_compile() {
	local myopts

	if [ -n "`use gnome`" ]
	then
		myopts="${myopts} --with-gnome"
	else
		myopts="${myopts} --without-gnome"
	fi

	if [ "`use 3dnow`" ] ; then
		myopts="${myopts} --enable-3dnow"
	else
		myopts="${myopts} --disable-3dnow"
	fi

	if [ "`use esd`" ] ; then
		myopts="${myopts} --enable-esd"
	else
		myopts="${myopts} --disable-esd"
	fi	

	if [ "`use opengl`" ] ; then
		myopts="${myopts} --enable-opengl"
	else
		myopts="${myopts} --disable-opengl"
	fi
	
	if [ "`use oggvorbis`" ] ; then
		myopts="${myopts} --with-ogg --with-vorbis"
	else
		myopts="${myopts} --disable-ogg-test --disable-vorbis-test"
	fi

	if [ ! "`use nls`" ] ; then
		myopts="${myopts} --disable-nls"
	fi

	
	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		${myopts} || die

	emake || die
}

src_install() {                               
	make prefix=${D}/usr 						\
	     mandir=${D}/usr/share/man					\
	     sysconfdir=${D}/etc					\
	     sysdir=${D}/usr/share/applets/Multimedia 			\
	     GNOME_SYSCONFDIR=${D}/etc					\
	     install || die

	dodoc AUTHORS ChangeLog COPYING FAQ NEWS README TODO 
	
	insinto /usr/share/pixmaps/
	donewins gnomexmms/gnomexmms.xpm xmms.xpm
	doins xmms/xmms_logo.xpm
	insinto /usr/share/pixmaps/mini
	doins xmms/xmms_mini.xpm

	insinto /etc/X11/wmconfig
	donewins xmms/xmms.wmconfig xmms

	if [ "`use gnome`" ]
	then
		insinto /usr/share/gnome/apps/Multimedia
		doins xmms/xmms.desktop
		dosed "s:xmms_mini.xpm:mini/xmms_mini.xpm:" \
			/usr/share/gnome/apps/Multimedia/xmms.desktop
	fi
}
