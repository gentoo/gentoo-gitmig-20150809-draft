# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fvwm/fvwm-2.5.7.ebuild,v 1.10 2003/07/31 10:57:40 taviso Exp $

inherit gnuconfig

IUSE="readline gtk stroke gnome rplay xinerama cjk perl nls png bidi"

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
		stroke? ( >=dev-libs/libstroke-0.4 )
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

	# use readline in FvwmConsole.
	if ! use readline; then
		myconf="${myconf} --without-readline-library"
	fi

	# fvwm configure doesnt provide a way to disable gtk support if the 
	# required libraries are found, this hides them from the script.
	if ! use gtk; then 
		myconf="${myconf} --with-gtk-prefix=${T} --with-imlib-prefix=${T}"
	fi
	
	# link with the gnome libraries, for better integration with the gnome desktop.
	if use gnome; then
		myconf="${myconf} --with-gnome" 
	else
		myconf="${myconf} --without-gnome" 
	fi
	
	# rplay is a cool, but little used way of playing sounds over a network
	# Fvwm support is pretty good.
	if ! use rplay; then
		myconf="${myconf} --without-rplay-library"
	fi

	# Install perl bindings for FvwmPerl.
	if use perl; then 
		myconf="${myconf} --enable-perllib" 
	else
		myconf="${myconf} --disable-perllib"
	fi
		
	# xinerama support for those who have multi-headed machines.
	if use xinerama; then
		myconf="${myconf} --enable-xinerama" 
	else
		myconf="${myconf} --disable-xinerama"
	fi

	# multibyte character support, chinese/japanese/korean/etc.
	if use cjk; then
		myconf="${myconf} --enable-multibyte" 
	else
		myconf="${myconf} --disable-multibyte"
	fi

	# bidirectional writing support, eg hebrew
	if use bidi; then
		myconf="${myconf} --enable-bidi"
	else
		myconf="${myconf} --disable-bidi"
	fi

	# png image support (very nice in fvwm)
	if ! use png; then
		myconf="${myconf} --without-png-library"
	fi
	
	# native language support
	if use nls; then
		myconf="${myconf} --enable-nls"
	else
		myconf="${myconf} --disable-nls"
	fi

	# support for mouse gestures using libstroke (very very cool)
	if ! use stroke; then
		myconf="${myconf} --without-stroke-library"
	fi
	
	# Xft detection is broken in this release, the fix is in cvs
	# which ive installed here, rerun automake to sort the problem.
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
	
	# must specify PKG_CONFIG or Xft detection bombs.
	econf ${myconf} PKG_CONFIG=/usr/bin/pkg-config || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die
	
	echo "#!/bin/bash" > fvwm2
	echo "exec /usr/bin/fvwm2" >> fvwm2

	exeinto /etc/X11/Sessions
	doexe fvwm2

	dodoc AUTHORS ChangeLog COPYING README NEWS docs/ANNOUNCE docs/BUGS \
	docs/COMMANDS docs/DEVELOPERS docs/FAQ docs/error_codes docs/TODO \
	docs/fvwm.lsm

}

pkg_postinst() {
	local i
	ewarn
	ewarn "The Gentoo FVWM ebuild has been altered since the 2.4.x Branch."
	ewarn "The following features that you did not request are now"
	ewarn "controlled via USE flags, and not enabled automatically:"
	use readline	|| ewarn "	Readline support in FvwmConsole [readline]"
	use stroke		|| ewarn "	Mouse Gestures [stroke]"
	use xinerama	|| ewarn "	Xinerama Support [xinerama]"
	use cjk			|| ewarn "	Multibyte Character Support [cjk]"
	use perl		|| ewarn "	FVWM Perl bindings [perl]"
	use nls			|| ewarn "	Native Language Support [nls]"
	use png			|| ewarn "	PNG Support [png]"
	use bidi		|| ewarn "	Bidirectional Language Support [bidi]"
	use rplay		|| ewarn "	RPlay Support in FvwmEvent [rplay]"
	use gtk			|| ewarn "	FvwmGTK (gtk+ support) (previously didnt honour USE flag) [gtk]"
	ewarn
	ewarn "If you require any of the features listed above, you should remerge"
	ewarn "FVWM with the appropriate USE flags. Use this command to see the flags"
	ewarn "available:"
	ewarn "	$ emerge -pv fvwm"
	ewarn
	
	for ((i=0;i<5;i++)); do echo -ne '\a'; sleep 1; done
}
