# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fvwm/fvwm-2.4.18.ebuild,v 1.7 2004/10/19 08:26:40 usata Exp $

inherit gnuconfig

IUSE="readline ncurses gtk stroke gnome rplay xinerama cjk imlib"

DESCRIPTION="an extremely powerful ICCCM-compliant multiple virtual desktop window manager"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${P}.tar.bz2"
HOMEPAGE="http://www.fvwm.org/"

SLOT="0"
KEYWORDS="x86 alpha ppc sparc"
LICENSE="GPL-2 FVWM"

RDEPEND="readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.3-r1 )
		gtk? ( =x11-libs/gtk+-1.2*
				imlib? ( >=media-libs/gdk-pixbuf-0.21.0
						>=media-libs/imlib-1.9.14-r1 ) )
		gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
		rplay? ( >=media-sound/rplay-3.3.2 )
		stroke? ( >=dev-libs/libstroke-0.4 )
		>=dev-lang/perl-5.8.0
		sys-apps/debianutils
		virtual/x11"
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	!x11-wm/metisse"

src_unpack() {
	unpack ${A}
	gnuconfig_update

	# CFLAGS containing comma will break this, so change it for !
	sed -i 's#\x27s,xCFLAGSx,$(CFLAGS),\x27#\x27s!xCFLAGSx!$(CFLAGS)!\x27#' ${S}/utils/Makefile.am
}

src_compile() {
	local myconf="--libexecdir=/usr/lib"

	# use readline in FvwmConsole.
	if ! use readline; then
		myconf="${myconf} --without-readline-library"
	else
		myconf="${myconf} --with-readline-library"

		myconf="${myconf} --without-termcap-library"
	fi

	# fvwm configure doesnt provide a way to disable gtk support if the
	# required libraries are found, this hides them from the script.
	if ! use gtk; then
		myconf="${myconf} --with-gtk-prefix=${T} --with-imlib-prefix=${T}"
	else
		if ! use imlib; then
			myconf="${myconf} --with-imlib-prefix=${T}"
		fi
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

	# support for mouse gestures using libstroke (very very cool)
	if ! use stroke; then
		myconf="${myconf} --without-stroke-library"
	fi

	econf ${myconf} || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	echo "#!/bin/bash" > fvwm2
	echo "exec /usr/bin/fvwm2" >> fvwm2

	exeinto /etc/X11/Sessions
	doexe fvwm2

	dodoc AUTHORS ChangeLog COPYING README NEWS docs/ANNOUNCE docs/BUGS \
	docs/DEVELOPERS docs/FAQ docs/error_codes docs/color_combos docs/TODO \
	docs/fvwm.lsm
}
