# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer: Achim Gottinger <achim@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-sound/xmms/xmms-1.2.7-r3.ebuild,v 1.4 2002/05/23 06:50:14 seemant Exp $

S=${WORKDIR}/${P}
DESCRIPTION="X MultiMedia System"
SRC_URI="ftp://ftp.xmms.org/xmms/1.2.x/${P}.tar.gz http://www.openface.ca/~nephtes/plover-xmms127.tar.gz"
HOMEPAGE="http://www.xmms.org/"

DEPEND="=x11-libs/gtk+-1.2*
	>=dev-libs/libxml-1.8.15
	>=media-libs/libmikmod-3.1.9
	esd? ( >=media-sound/esound-0.2.22 )
	oggvorbis? ( >=media-libs/libvorbis-1.0_beta4 )
	opengl? ( virtual/opengl )
	avi? ( >=media-video/avifile-0.6 )
	gnome? ( >=gnome-base/gnome-libs-1.4.1.4 )
	sdl? ( media-libs/libsdl )"
	

RDEPEND="${DEPEND}
	nls? ( dev-util/intltool
		sys-devel/gettext )"

src_unpack() {
	unpack ${P}.tar.gz

	cd ${S}
	cp configure configure.orig
	sed -e "s:-m486::" configure.orig > configure
	
	use avi	\
		&& unpack plover-xmms127.tar.gz	\
		&& patch -p1 < plover-xmms127.diff	\
		&& touch stamp-h1.in xmms/stamp-h2.in
}

src_compile() {

	libtoolize --copy --force
	aclocal

	local myopts

	use gnome	\
		&& myopts="${myopts} --with-gnome"	\
		|| myopts="${myopts} --without-gnome"

	use 3dnow	\
		&& myopts="${myopts} --enable-3dnow"	\
		|| myopts="${myopts} --disable-3dnow"

	use esd	\
		&& myopts="${myopts} --enable-esd"	\
		|| myopts="${myopts} --disable-esd"

	use opengl	\
		&& myopts="${myopts} --enable-opengl"	\
		|| myopts="${myopts} --disable-opengl"
	
	use oggvorbis	\
		&& myopts="${myopts} --with-ogg --with-vorbis"	\
		|| myopts="${myopts} --disable-ogg-test --disable-vorbis-test"

	use nls	\
		|| myopts="${myopts} --disable-nls --without-libintl-prefix"

	
	./configure	\
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--enable-one-plugin-dir	\
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

	use gnome	\
		&& insinto /usr/share/gnome/apps/Multimedia	\
		&& doins xmms/xmms.desktop	\
		&& dosed "s:xmms_mini.xpm:mini/xmms_mini.xpm:" \
			/usr/share/gnome/apps/Multimedia/xmms.desktop
}
