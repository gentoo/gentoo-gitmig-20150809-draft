# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fvwm/fvwm-2.5.7-r5.ebuild,v 1.3 2004/01/13 12:19:03 taviso Exp $

inherit gnuconfig

IUSE="readline truetype ncurses gtk stroke gnome rplay xinerama cjk perl nls png bidi imlib tcltk debug gtk2"

S=${WORKDIR}/${P}
DESCRIPTION="An extremely powerful ICCCM-compliant multiple virtual desktop window manager"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${P}.tar.bz2
		perl? ( mirror://gentoo/FvwmTabs-2.3.tar.gz )"
HOMEPAGE="http://www.fvwm.org/"

SLOT="0"
KEYWORDS="x86 sparc alpha"
LICENSE="GPL-2 FVWM"

RDEPEND="readline? ( >=sys-libs/readline-4.1
				ncurses? ( >=sys-libs/ncurses-5.3-r1 )
				!ncurses? ( >=sys-libs/libtermcap-compat-1.2.3 ) )
		gtk? ( =x11-libs/gtk+-1.2*
				imlib? ( >=media-libs/gdk-pixbuf-0.21.0
						>=media-libs/imlib-1.9.14-r1 ) )
		gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 )
		rplay? ( >=media-sound/rplay-3.3.2 )
		bidi? ( >=dev-libs/fribidi-0.10.4 )
		png? ( >=media-libs/libpng-1.0.12-r2 )
		stroke? ( >=dev-libs/libstroke-0.4 )
		perl? ( tcltk? ( >=dev-lang/tk-8.3.4
						>=dev-perl/perl-tk-800.024-r2
						>=dev-perl/X11-Protocol-0.51-r1 ) )
		truetype? ( virtual/xft
					>=media-libs/fontconfig-2.1-r1
					>=dev-libs/expat-1.95.6-r1 )
		!noxpm? ( >=media-libs/netpbm-9.12-r4 )
		>=dev-lang/perl-5.6.1-r10
		>=sys-libs/zlib-1.1.4-r1
		virtual/x11"
# XXX:	gtk2 perl bindings require dev-perl/gtk2-perl, worth a dependency?
# XXX:	gtk perl bindings require dev-perl/gtk-perl, worth a dependency?
# XXX:	netpbm is used by FvwmScript-ScreenDump...im assuming anyone with 
# 	`use noxpm` will not want them.
DEPEND="${RDEPEND}
	>=sys-apps/sed-4
	sys-devel/automake
	sys-devel/autoconf
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}

	use alpha && gnuconfig_update

	# CFLAGS containing comma (eg -mfpmath=sse,387) will break this, so change it for !
	sed -i 's#\x27s,xCFLAGSx,$(CFLAGS),\x27#\x27s!xCFLAGSx!$(CFLAGS)!\x27#' ${S}/utils/Makefile.am

	# Xft detection is totally b0rked if using pkg-config, this update from cvs.
	cp ${FILESDIR}/acinclude.m4 ${S}/acinclude.m4
}

src_compile() {
	local myconf="--libexecdir=/usr/lib --with-imagepath=/usr/include/X11/bitmaps:/usr/include/X11/pixmaps:/usr/share/icons/fvwm"

	# ImagePath should include /usr/share/icons/fvwm (x11-themes/fvwm_icons)
	#
	# Another iconset for fvwm, wm-icons, includes configurations and user
	# configuration utilities to make them easy to use with fvwm, no need
	# to put them in the default ImagePath.

	# use readline in FvwmConsole.
	if ! use readline; then
		myconf="${myconf} --without-readline-library"
	else
		myconf="${myconf} --with-readline-library"

		# choose ncurses or termcap.
		if use ncurses; then
			myconf="${myconf} --without-termcap-library"
		else
			myconf="${myconf} --without-ncurses-library"
		fi
	fi

	# fvwm configure doesnt provide a way to disable gtk support if the
	# required libraries are found, this hides them from the script.
	# Print a message indicating the errors are normal.
	if ! use gtk; then
		einfo "ATTN: You can safely ignore any gtk related configure errors."
		einfo "ATTN: You can safely ignore any imlib related configure errors."
		myconf="${myconf} --with-gtk-prefix=${T} --with-imlib-prefix=${T}"
	else
		if ! use imlib; then
			einfo "ATTN: You can safely ignore any imlib related configure errors."
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

	# more verbosity for module developers/hackers/etc.
	if use debug; then
		myconf="${myconf} --enable-debug-msgs --enable-command-log"
	fi

	# Xft Anti Aliased text support (yummy eye candy)
	if use truetype; then
		myconf="${myconf} --enable-xft"
	else
		myconf="${myconf} --disable-xft"
	fi

	# disable xsm protocol (session management) support?
	# `nosm` instead of `sm` as some people dont check USE flags
	if use nosm; then
		myconf="${myconf} --disable-sm"
	else
		myconf="${myconf} --enable-sm"
	fi

	# disable xpm support? (maybe you only use png in your themes, or just solid colour?)
	# `noxpm` instead of `xpm`, as most people will want this.
	if use noxpm; then
		myconf="${myconf} --without-xpm-library"
	fi

	# Xft detection is broken in this release, the fix is in cvs
	# which ive installed here, rerun automake to sort the problem.
	# This is only nescessary if `truetype` is required.
	if use truetype; then
		einfo "Fixing Xft detection, please wait..."
		(	ebegin "	Running aclocal"
			aclocal; eend $?

			ebegin "	Running autoheader"
			autoheader; eend $?

			ebegin "	Running automake"
			automake --add-missing; eend $?

			ebegin "	Running autoreconf"
			autoreconf; eend $?	) 2>/dev/null
		einfo "Fixed."
	fi

	# must specify PKG_CONFIG or Xft detection bombs.
	econf ${myconf} PKG_CONFIG=/usr/bin/pkg-config || die
	emake || die
}

src_install() {

	make DESTDIR=${D} install || die

	if use perl; then

		local toolkits="gtk2 gtk tcltk"

		if use tcltk; then
			# Install the very cool FvwmTabs module
			# http://users.tpg.com.au/users/scottie7/FvwmTabs
			einfo "Installing FvwmTabs module..."

			exeinto /usr/lib/fvwm/${PV}/
			doexe ${WORKDIR}/FvwmTabs
			dodoc ${WORKDIR}/fvwmtabrc ${WORKDIR}/README.fvwmtabs
			doman ${WORKDIR}/FvwmTabs.1
		else
			# Remove the Tk bindings (requires perl-tk)
			rm -f ${D}/usr/share/fvwm/perllib/FVWM/Module/Tk.pm
			toolkits=${toolkits/tcltk/}
		fi
		if ! use gtk; then
			# Remove gtk bindings (requires gtk-perl/gtk2-perl)
			rm -f ${D}/usr/share/fvwm/perllib/FVWM/Module/Gtk.pm \
				${D}/usr/share/fvwm/perllib/FVWM/Module/Gtk2.pm
			toolkits=${toolkits/gtk2/}
			toolkits=${toolkits/gtk/}
		else
			if ! use gtk2; then
				# Just remove the gtk2 bindings (requires gtk2-perl)
				rm -f ${D}/usr/share/fvwm/perllib/FVWM/Module/Gtk2.pm
				toolkits=${toolkits/gtk2/}
			fi
		fi
		toolkits=${toolkits// /}
		if ! test "${toolkits}"; then
			# No perl toolkit bindings wanted, remove the unneeded files
			# and empty directories.
			rm -f ${D}/usr/share/fvwm/perllib/FVWM/Module/Toolkit.pm
			find ${D}/usr/share/fvwm/perllib -depth -type d -exec rmdir {} \; 2>/dev/null
		fi
	else
		# Remove useless script if perllib isnt required.
		rm -rf ${D}/usr/bin/fvwm-perllib ${D}/usr/share/man/man1/fvwm-perllib.1
	fi

	# fvwm-convert-2.6 is just a stub, contains no code - remove it for now.
	# fvwm-convert-2.2 has a man page, but the script is no longer distributed.
	rm -f ${D}/usr/bin/fvwm-convert-2.6 ${D}/usr/share/man/man1/fvwm-convert-2.6.1
	rm -f ${D}/usr/share/man/man1/fvwm-convert-2.2.1

	# ive included `exec` to save a few bytes of memory.
	echo "#!/bin/bash" > fvwm2
	echo "exec /usr/bin/fvwm2" >> fvwm2

	exeinto /etc/X11/Sessions
	doexe fvwm2

	dodoc AUTHORS ChangeLog COPYING README NEWS docs/ANNOUNCE docs/BUGS \
	docs/COMMANDS docs/DEVELOPERS docs/FAQ docs/error_codes docs/TODO \
	docs/fvwm.lsm

	dodoc utils/fvwm_make_directory_menu.sh  utils/fvwm_make_browse_menu.sh \
	utils/quantize_pixmaps utils/xselection.c

	# fix a couple of symlinks.
	prepallman
}

pkg_postinst() {
	if use perl; then
		if use tcltk; then
			einfo "By setting the perl and tcltk USE flags, you have elected to"
			einfo "install the FvwmTabs module, a configurable tabbing system"
			einfo "for FVWM. You can read more about FvwmTabs here:"
			einfo
			einfo "	http://users.tpg.com.au/users/scottie7/fvwmtabs.html"
			einfo
		fi
	fi
}
