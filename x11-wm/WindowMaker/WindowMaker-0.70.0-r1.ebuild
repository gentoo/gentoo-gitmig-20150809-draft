# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Daniel Robbins <drobbins@gentoo.org>

S=${WORKDIR}/${P}
DESCRIPTION="Window Maker"
SRC_URI="ftp://ftp.windowmaker.org/pub/source/release/${P}.tar.gz
	 ftp://ftp.windowmaker.org/pub/source/release/WindowMaker-extra-0.1.tar.bz2"
HOMEPAGE="http://www.windowmaker.org/"

DEPEND="virtual/glibc virtual/x11
	>=media-libs/tiff-3.5.5
	>=media-libs/libpng-1.0.12
	>=media-libs/jpeg-6b-r2
	x11-wm/gnustep-env
	gif? ( >=media-libs/giflib-4.1.0-r3 )
	ungif? ( >=media-libs/libungif-4.1.0 )
	nls? ( >=sys-devel/gettext-0.10.39 )"
# Replaced by WINGS
#	>=x11-libs/libPropList-0.10.1"


src_compile() {

	local myconf
	if [ "`use gnome`" ] ; then
		myconf="--enable-gnome"
	fi
	if [ "`use kde`" ] ; then
		myconf="$myconf --enable-kde"
	fi
	if [ "`use nls`" ] ; then
 		LINGUAS="`ls po/*.po | xargs -i basename {} .po`"
		export LINGUAS
	fi

	./configure --host=${CHOST}					\
		    --prefix=/usr					\
		    --mandir=/usr/share/man				\
		    --infodir=/usr/share/info				\
		    --sysconfdir=/etc/X11				\
		    --with-nlsdir=/usr/share/locale			\
		    --with-x						\
		    --enable-newstyle					\
		    --enable-superfluous				\
		    --enable-usermenu					\
		    $myconf || die
		    
	make || die
  
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
	     NLSDIR=${D}/usr/share/locale				\
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

