# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# Author Daniel Robbins <drobbins@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/x11-wm/WindowMaker/WindowMaker-0.80.0-r3.ebuild,v 1.2 2002/04/18 00:39:48 spider Exp $

S=${WORKDIR}/${P}
DESCRIPTION="Window Maker"
SRC_URI="ftp://ftp.windowmaker.org/pub/source/release/${P}.tar.gz
	 ftp://ftp.windowmaker.org/pub/source/release/WindowMaker-extra-0.1.tar.bz2"
HOMEPAGE="http://www.windowmaker.org/"
SLOT="0"
DEPEND="virtual/x11
	>=media-libs/xpm-3.4k
	>=media-libs/tiff-3.5.5
	x11-wm/gnustep-env
	png? ( >=media-libs/libpng-1.2.1 )
	jpeg? ( >=media-libs/jpeg-6b-r2 )
	gif? ( >=media-libs/giflib-4.1.0-r3 
		>=media-libs/libungif-4.1.0 )"

RDEPEND="nls? ( >=sys-devel/gettext-0.10.39 )"

#NOTE: the default menu has the wrong path for the WMPrefs utility.  
# Needs fixing.

src_compile() {

	patch -p1 < ${FILESDIR}/wmfpo-80.patch    

	local myconf

	use gnome	\
		&& myconf="${myconf} --enable-gnome"	\
		|| myconf="${myconf} --disable-gnome"
	
	use kde	\
		&& myconf="${myconf} --enable-kde"	\
		&& export KDEDIR=/usr/kde/2	\
		|| myconf="${myconf} --disable-kde"
	
	if [ "$WITH_MODELOCK" ] ; then
		myconf="${myconf} --enable-modelock"
	else
		myconf="${myconf} --disable-modelock"
	fi
	
	use nls	\
		&& export LINGUAS="`ls po/*.po | sed 's:po/\(.*\)\.po$:\1:'`"	\
		|| myconf="${myconf} --disable-nls --disable-locale"

	use gif	\
		|| myconf="${myconf} --disable-gif"

	use jpeg	\
		|| myconf="${myconf} --disable-jpeg"
	
	use png	\
		|| myconf="${myconf} --disable-png"
		

	use esd || use alsa || use oss	\
		&& myconf="${myconf} --enable-sound"	\
		|| myconf="${myconf} --disable-sound"

	./configure	\
		--host=${CHOST}					\
		--prefix=/usr					\
		--mandir=/usr/share/man				\
		--infodir=/usr/share/info				\
		--sysconfdir=/etc/X11				\
		--with-x						\
		--enable-newstyle					\
		--enable-superfluous				\
		--enable-usermenu					\
		${myconf} || die
		    
	emake || die
  
  	# WindowMaker Extra
	cd ../WindowMaker-extra-0.1
	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info || die
		    
	make || die
}

src_install() {

	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     sysconfdir=${D}/etc/X11					\
	     GNUSTEP_LOCAL_ROOT=${D}${GNUSTEP_LOCAL_ROOT}		\
	     install || die

	cp -f WindowMaker/plmenu ${D}/etc/X11/WindowMaker/WMRootMenu

	dodoc AUTHORS BUGFORUM BUGS ChangeLog COPYING* INSTALL* FAQ*	\
	      MIRRORS README* NEWS TODO

	# WindowMaker Extra
	cd ../WindowMaker-extra-0.1
	make prefix=${D}/usr						\
	     mandir=${D}/usr/share/man					\
	     infodir=${D}/usr/share/info				\
	     install || die
	
	newdoc README README.extra
}

