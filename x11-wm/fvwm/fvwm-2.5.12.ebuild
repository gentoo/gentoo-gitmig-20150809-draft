# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fvwm/fvwm-2.5.12.ebuild,v 1.4 2004/10/19 08:26:40 usata Exp $

inherit eutils flag-o-matic

IUSE="bidi debug gnome gtk gtk2 imlib ncurses nls nosm noxpm perl png readline rplay stroke tcltk truetype xinerama"

DESCRIPTION="An extremely powerful ICCCM-compliant multiple virtual desktop window manager"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${P}.tar.bz2
		mirror://gentoo/fvwm-2.5.11-translucent-menus.diff.gz
		perl? ( http://users.tpg.com.au/users/scottie7/FvwmTabs-v3.3.tar.gz	)"
HOMEPAGE="http://www.fvwm.org/"

SLOT="0"
KEYWORDS="~x86 ~ppc64 ~ppc ~amd64 ~sparc"
LICENSE="GPL-2 FVWM"

RDEPEND="readline? ( >=sys-libs/readline-4.1 >=sys-libs/ncurses-5.3-r1 )
		gtk? ( =x11-libs/gtk+-1.2*
				imlib? ( >=media-libs/gdk-pixbuf-0.21.0
						>=media-libs/imlib-1.9.14-r1 )
				gnome? ( >=gnome-base/gnome-libs-1.4.1.2-r1 ) )
		rplay? ( >=media-sound/rplay-3.3.2 )
		bidi? ( >=dev-libs/fribidi-0.10.4 )
		png? ( >=media-libs/libpng-1.0.12-r2 )
		stroke? ( >=dev-libs/libstroke-0.4 )
		perl? ( tcltk? ( >=dev-lang/tk-8.3.4
						>=dev-perl/perl-tk-800.024-r2
						>=dev-perl/X11-Protocol-0.52 ) )
		truetype? ( virtual/xft >=media-libs/fontconfig-2.1-r1 )
		>=dev-lang/perl-5.6.1-r10
		>=sys-libs/zlib-1.1.4-r1
		sys-apps/debianutils
		virtual/x11"
# XXX:	gtk2 perl bindings require dev-perl/gtk2-perl, worth a dependency?
# XXX:	gtk perl bindings require dev-perl/gtk-perl, worth a dependency?
# XXX:	netpbm is used by FvwmScript-ScreenDump, worth a dependency?
DEPEND="${RDEPEND} dev-util/pkgconfig
	!x11-wm/metisse"

SFT=${WORKDIR}/FvwmTabs-v3.3

src_unpack() {
	unpack ${A}

	# this patch enables fast translucent menus in fvwm..yummy! this is a
	# minor tweak of a patch posted to fvwm-user mailing list by Olivier
	# Chapuis in <20030827135125.GA6370@snoopy.folie>.
	cd ${S}; epatch ${WORKDIR}/fvwm-2.5.11-translucent-menus.diff

	# according to a post to fvwm-workers mailing list, Mikhael Goikhman
	# planned on disabling these debug statements before the release, but
	# never got around to it.
	# XXX: incvs
	cd ${S}; epatch ${FILESDIR}/disable-debug-statements.diff

	if use perl; then
		# I'll supply a default icon for FvwmTabs, this removes the need for
		# installing an iconset, this one comes from the fvwm_icons package.
		cd ${SFT}
		ebegin "	Setting default icon for FvwmTabs"
			sed -i 's#happyMini.xpm#/usr/share/fvwm/mini-happy.xpm#g' \
				FvwmTabs FvwmTabs.1 fvwmtabrc
		eend $?
	fi

	# fixing #51287, the fvwm-menu-xlock script is not compatible
	# with the xlockmore implementation in portage.
	cd ${S}; epatch ${FILESDIR}/fvwm-menu-xlock-xlockmore-compat.diff

	# build fails on alpha with certain options without this.
	use alpha && append-flags -fPIC
}

src_compile() {
	local myconf="--libexecdir=/usr/lib --with-imagepath=/usr/include/X11/bitmaps:/usr/include/X11/pixmaps:/usr/share/icons/fvwm --enable-package-subdirs"

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

		myconf="${myconf} --without-termcap-library"
	fi

	# since fvwm-2.5.8 GTK support can be diabled with --disable-gtk, previously
	# we had to hide the includes/libs during configure. this is still the case
	# for GDK image suport _with_ gtk, unfortunately.
	# FvwmGtk can be built as a gnome application, or a Gtk+ application.
	if ! use gtk; then
		myconf="${myconf} --disable-gtk --without-gnome"
	else
		if ! use imlib; then
			einfo "ATTN: You can safely ignore any imlib related configure errors."
			myconf="${myconf} --with-imlib-prefix=${T}"
		fi
		if ! use gnome; then
			myconf="${myconf} --without-gnome"
		else
			myconf="${myconf} --with-gnome"
		fi
	fi

	# rplay is a cool, but little used way of playing sounds over a network
	# Fvwm support is pretty good.
	if ! use rplay; then
		myconf="${myconf} --without-rplay-library"
	fi

	# Install perl bindings.
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
		myconf="${myconf} --enable-nls --enable-iconv"
	else
		myconf="${myconf} --disable-nls --disable-iconv"
	fi

	# support for mouse gestures using libstroke (very very cool)
	if ! use stroke; then
		myconf="${myconf} --without-stroke-library"
	fi

	# more verbosity for module developers/hackers/etc.
	if use debug; then
		myconf="${myconf} --enable-debug-msgs --enable-command-log"
		# XXX: incvs will no longer be needed in 2.5.13, configurable at run time
		append-flags -DCR_DETECT_MOTION_METHOD_DEBUG
	fi

	# Xft Anti Aliased text support
	if use truetype; then
		myconf="${myconf} --enable-xft"
	else
		myconf="${myconf} --disable-xft"
	fi

	# disable xsm protocol (session management) support?
	if use nosm; then
		myconf="${myconf} --disable-sm"
	else
		myconf="${myconf} --enable-sm"
	fi

	# disable xpm support?
	if use noxpm; then
		myconf="${myconf} --without-xpm-library"
	fi

	# set the local maintainer for fvwm-bug.
	export FVWM_BUGADDR="taviso@gentoo.org"

	econf ${myconf} || die
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
			doexe ${SFT}/FvwmTabs

			dodoc ${SFT}/fvwmtabrc ${SFT}/tab.zsh
			doman ${SFT}/FvwmTabs.1
			dohtml ${SFT}/FvwmTabs.man.html

			newdoc ${SFT}/README README.fvwmtabs

			# install default drag and drop icon.
			insinto /usr/share/fvwm
			newins ${FILESDIR}/mini.happy.xpm mini-happy.xpm
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

	# neat utility for testing fvwm behaviour on applications setting various
	# hints, creates a simple black window with configurable hints set.
	if use debug; then
		dobin ${S}/tests/hints/hints_test
		newdoc ${S}/tests/hints/README README.hints
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

	dodoc ${FILESDIR}/README.transluceny.gz

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
	echo
	einfo "If you have been using the 'ShowOnlyIcons never' syntax in"
	einfo "FvwmIconMan, please update your configuration to use the new "
	einfo "officially supported 'ShowNoIcons' option."
	echo
	einfo "The FvwmButtons 'HoverIcon', 'HoverTitle' and 'HoverColorset'"
	einfo "features have been renamed 'Active'. Please update your"
	einfo "configuration accordingly."
	echo
	einfo 'The $[w.miniiconfile] and $[w.iconfile] expansion has changed, if'
	einfo "the image exists in your ImagePath, it will now expand to the full"
	einfo "path of the image."
	echo
	einfo "For in depth information about all changes in this release, please"
	einfo "refer to the ChangeLog."
	echo
}
