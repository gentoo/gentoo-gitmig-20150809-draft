# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fvwm/fvwm-2.5.7.ebuild,v 1.7 2003/07/30 22:28:10 taviso Exp $

inherit gnuconfig

IUSE="readline gtk gnome rplay xinerama cjk perl nls png"

S=${WORKDIR}/${P}
DESCRIPTION="an extremely powerful ICCCM-compliant multiple virtual desktop window manager"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${P}.tar.bz2"
HOMEPAGE="http://www.fvwm.org/"

SLOT="0"
KEYWORDS="~x86 ~alpha"
LICENSE="GPL-2 FVWM"

RDEPEND="readline? ( >=sys-libs/readline-4.1 )
		gtk? ( =x11-libs/gtk+-1.2* )
		gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
		rplay? ( media-sound/rplay )
		perl? ( dev-lang/perl )	
		bidi? ( >=dev-libs/fribidi-0.10.4 )
		png? ( media-libs/libpng )
		>=dev-libs/libstroke-0.4
		media-libs/fontconfig
		dev-libs/expat"
DEPEND="${RDEPEND} 
	sys-devel/automake
	sys-devel/autoconf
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	
	use alpha && gnuconfig_update
	
	# CFLAGS containing comma will break this, so change it for !
	sed -i 's#\x27s,xCFLAGSx,$(CFLAGS),\x27#\x27s!xCFLAGSx!$(CFLAGS)!\x27#' ${S}/utils/Makefile.am

	# Xft detection is totally b0rked if using pkg-config, this update from cvs.	
	cp ${FILESDIR}/acinclude.m4 ${S}/acinclude.m4
}

src_compile() {
	local myconf="--libexecdir=/usr/lib --enable-xft"

	use readline \
		|| myconf="${myconf} --without-readline-library"

	use gtk \
		|| myconf="${myconf} --with-gtk-prefix=/var/empty --with-imlib-prefix=/var/empty"
		
	use gnome \
		&& myconf="${myconf} --with-gnome" \
		|| myconf="${myconf} --without-gnome" 
	
	use rplay \
		|| myconf="${myconf} --without-rplay-library"

	use perl \
		&& myconf="${myconf} --enable-perllib" \
		|| myconf="${myconf} --disable-perllib"
		
	use xinerama \
		&& myconf="${myconf} --enable-xinerama" \
		|| myconf="${myconf} --disable-xinerama"

	use cjk \
		&& myconf="${myconf} --enable-multibyte" \
		|| myconf="${myconf} --disable-multibyte"

	use bidi \
		&& myconf="${myconf} --enable-bidi" \
		|| myconf="${myconf} --disable-bidi"

	use png \
		|| myconf="${myconf} --without-png-library"
	
	use nls \
		&& myconf="${myconf} --enable-nls" \
		|| myconf="${myconf} --disable-nls"
	
	einfo "Fixing Xft detection, please wait..."
 	(	einfo "	Running aclocal..."
		aclocal
		einfo "	Running autoheader..."
		autoheader
		einfo "	Running automake..."
		automake --add-missing
		einfo "	Running autoreconf..."
		autoreconf ) 2>/dev/null
	einfo "Fixed."
	
	econf ${myconf} PKG_CONFIG=/usr/bin/pkg-config || die
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	
	echo "#!/bin/bash" > fvwm2
	echo "/usr/bin/fvwm2" >> fvwm2

	exeinto /etc/X11/Sessions
	doexe fvwm2
}

