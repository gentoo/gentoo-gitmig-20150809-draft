# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fvwm/fvwm-2.5.21.ebuild,v 1.1 2007/03/23 19:29:55 taviso Exp $

inherit eutils flag-o-matic

DESCRIPTION="An extremely powerful ICCCM-compliant multiple virtual desktop window manager"
HOMEPAGE="http://www.fvwm.org/"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${P}.tar.bz2 mirror://gentoo/fvwm-2.5.21-translucent-menus.diff.gz"

LICENSE="GPL-2 FVWM"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86"
IUSE="bidi debug gtk imlib nls perl png readline rplay stroke tk truetype xinerama"

RDEPEND="readline? ( sys-libs/readline sys-libs/ncurses )
		gtk? ( =x11-libs/gtk+-1.2* imlib? ( media-libs/imlib ) )
		rplay? ( media-sound/rplay )
		bidi? ( dev-libs/fribidi )
		png? ( media-libs/libpng )
		stroke? ( dev-libs/libstroke )
		perl? ( tk? (
					dev-lang/tk
					dev-perl/perl-tk
					>=dev-perl/X11-Protocol-0.56 ) )
		truetype? ( virtual/xft media-libs/fontconfig )
		userland_GNU? ( sys-apps/debianutils )
		dev-lang/perl
		sys-libs/zlib
		|| ( (
			x11-libs/libXpm
			x11-libs/libXft
			xinerama? ( x11-libs/libXinerama ) )
		virtual/x11 )"
# XXX:	gtk2 perl bindings require dev-perl/gtk2-perl, worth a dependency?
# XXX:	gtk perl bindings require dev-perl/gtk-perl, worth a dependency?
# XXX:	netpbm is used by FvwmScript-ScreenDump, worth a dependency?
DEPEND="${RDEPEND}
		dev-util/pkgconfig
		|| ( (
			x11-libs/libXrandr
			x11-proto/xextproto
			x11-proto/xproto
			xinerama? ( x11-proto/xineramaproto ) )
		virtual/x11 )"

src_unpack() {
	unpack ${A}; export EPATCH_OPTS="-F3 -l"

	# this patch enables fast translucent menus in fvwm. this is a
	# minor tweak of a patch posted to fvwm-user mailing list by Olivier
	# Chapuis in <20030827135125.GA6370@snoopy.folie>.
	cd ${S}; epatch ${WORKDIR}/fvwm-2.5.21-translucent-menus.diff

	# fixing #51287, the fvwm-menu-xlock script is not compatible
	# with the xlockmore implementation in portage.
	cd ${S}; epatch ${FILESDIR}/fvwm-menu-xlock-xlockmore-compat.diff
}

src_compile() {
	local myconf="--libexecdir=/usr/lib --with-imagepath=/usr/include/X11/bitmaps:/usr/include/X11/pixmaps:/usr/share/icons/fvwm --enable-package-subdirs"

	# use readline in FvwmConsole.
	if use readline; then
		myconf="${myconf} --without-termcap-library"
	fi

	# FvwmGtk can be built as a gnome application, or a Gtk+ application.
	if ! use gtk; then
		myconf="${myconf} --disable-gtk --without-gnome"
	else
		if ! use imlib; then
			einfo "ATTN: You can safely ignore any imlib related configure errors."
			myconf="${myconf} --with-imlib-prefix=${T}"
		fi
		myconf="${myconf} --without-gnome"
	fi

	# set the local maintainer for fvwm-bug.
	export FVWM_BUGADDR="taviso@gentoo.org"

	# reccommended by upstream
	append-flags -fno-strict-aliasing

	# signed chars are required
	if use ppc; then
		append-flags -fsigned-char
	fi

	econf ${myconf} `use_enable truetype xft` \
					`use_with stroke stroke-library` \
					`use_enable nls` \
					`use_enable nls iconv` \
					`use_enable png png-library` \
					`use_enable bidi` \
					`use_enable xinerama` \
					`use_enable debug debug-msgs` \
					`use_enable debug command-log` \
					`use_enable perl perllib` \
					`use_with readline readline-library` \
					`use_with rplay rplay-library` || die
	emake || die
}

src_install() {
	make DESTDIR=${D} install || die

	if use perl; then

		local toolkits="gtk tcltk"

		if ! use tk; then
			# Remove the Tk bindings (requires perl-tk)
			rm -f ${D}/usr/share/fvwm/perllib/FVWM/Module/Tk.pm
			toolkits=${toolkits/tcltk/}
		fi
		if ! use gtk; then
			# Remove gtk bindings (requires gtk-perl/gtk2-perl)
			rm -f ${D}/usr/share/fvwm/perllib/FVWM/Module/Gtk.pm \
				${D}/usr/share/fvwm/perllib/FVWM/Module/Gtk2.pm
			toolkits=${toolkits/gtk/}
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
	rm -f ${D}/usr/bin/fvwm-convert-2.6 ${D}/usr/share/man/man1/fvwm-convert-2.6.1

	# ive included `exec` to save a few bytes of memory.
	echo "#!/bin/bash" > fvwm2
	echo "exec /usr/bin/fvwm2" >> fvwm2

	exeinto /etc/X11/Sessions
	doexe fvwm2

	dodoc AUTHORS ChangeLog COPYING README NEWS docs/ANNOUNCE docs/BUGS \
	docs/COMMANDS docs/DEVELOPERS docs/FAQ docs/error_codes docs/TODO \
	docs/fvwm.lsm

	dodoc ${FILESDIR}/README.transluceny
}

pkg_postinst() {
	einfo
	einfo "For information about the changes in this release, please"
	einfo "refer to the NEWS file."
	einfo
}
