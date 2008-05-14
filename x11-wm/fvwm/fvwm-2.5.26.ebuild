# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/fvwm/fvwm-2.5.26.ebuild,v 1.1 2008/05/14 21:29:51 omp Exp $

inherit eutils flag-o-matic

DESCRIPTION="An extremely powerful ICCCM-compliant multiple virtual desktop window manager"
HOMEPAGE="http://www.fvwm.org/"
SRC_URI="ftp://ftp.fvwm.org/pub/fvwm/version-2/${P}.tar.bz2"

LICENSE="GPL-2 FVWM"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="bidi debug doc gtk gtk2-perl imlib netpbm nls perl png readline rplay stroke svg tk truetype vanilla xinerama"

COMMON_DEPEND="
	dev-libs/libxml2
	sys-libs/zlib
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXcursor
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXpm
	x11-libs/libXrandr
	x11-libs/libXrender
	bidi? ( dev-libs/fribidi )
	gtk? (
		=x11-libs/gtk+-1.2*
		imlib? ( media-libs/imlib )
	)
	png? ( media-libs/libpng )
	readline? (
		sys-libs/ncurses
		sys-libs/readline
	)
	stroke? ( dev-libs/libstroke )
	svg? ( gnome-base/librsvg )
	truetype? (
		media-libs/fontconfig
		virtual/xft
	)
	xinerama? (
		x11-proto/xineramaproto
		x11-libs/libXinerama
	)"

RDEPEND="${COMMON_DEPEND}
	dev-lang/perl
	gtk2-perl? ( dev-perl/gtk2-perl )
	perl? ( tk? (
			dev-lang/tk
			dev-perl/perl-tk
			>=dev-perl/X11-Protocol-0.56
		)
	)
	rplay? ( media-sound/rplay )
	userland_GNU? ( sys-apps/debianutils )
	!x86-fbsd? ( netpbm? ( media-libs/netpbm ) )"

DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
	doc? ( dev-libs/libxslt )
	x11-proto/xextproto
	x11-proto/xproto"

src_unpack() {
	unpack ${A}

	if ! use vanilla; then
		cd "${S}"

		# Enables fast translucent menus; patch from fvwm-user mailing list.
		epatch "${FILESDIR}/fvwm-2.5.23-translucent-menus.diff"

		# A Gentoo-specific compatibility patch.
		epatch "${FILESDIR}/fvwm-menu-xlock-xlockmore-compat.diff"
	fi
}

src_compile() {
	local myconf="--libexecdir=/usr/lib --with-imagepath=/usr/include/X11/bitmaps:/usr/include/X11/pixmaps:/usr/share/icons/fvwm --enable-package-subdirs --without-gnome"

	# Non-upstream email where bugs should be sent; used in fvwm-bug.
	export FVWM_BUGADDR="desktop-wm@gentoo.org"

	# Recommended by upstream.
	append-flags -fno-strict-aliasing

	# Signed chars are required.
	use ppc && append-flags -fsigned-char

	if use gtk; then
		if ! use imlib; then
			einfo "ATTN: You can safely ignore any imlib related configure errors."
			myconf="${myconf} --with-imlib-prefix=${T}"
		fi
	else
		myconf="${myconf} --disable-gtk"
	fi

	use readline && myconf="${myconf} --without-termcap-library"

	econf ${myconf} \
		$(use_enable bidi) \
		$(use_enable debug debug-msgs) \
		$(use_enable debug command-log) \
		$(use_enable doc htmldoc) \
		$(use_enable nls) \
		$(use_enable nls iconv) \
		$(use_enable perl perllib) \
		$(use_with png png-library) \
		$(use_with readline readline-library) \
		$(use_with rplay rplay-library) \
		$(use_with stroke stroke-library) \
		$(use_enable svg rsvg) \
		$(use_enable truetype xft) \
		$(use_enable xinerama) \
		|| die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	# These are always removed, because gentoo doesn't have anymore
	# a dev-perl/gtk-perl package, so, these modules are pointless.
	rm -f "${D}/usr/share/fvwm/perllib/FVWM/Module/Gtk.pm"
	find "${D}" -name '*FvwmGtkDebug*' -exec rm -f '{}' \; 2>/dev/null

	if use perl; then
		if ! use tk; then
			rm -f "${D}/usr/share/fvwm/perllib/FVWM/Module/Tk.pm"
			if ! use gtk2-perl; then # no tk and no gtk2 bindings
				rm -f "${D}/usr/share/fvwm/perllib/FVWM/Module/Toolkit.pm"
				find "${D}/usr/share/fvwm/perllib" -depth -type d -exec rmdir '{}' \; 2>/dev/null
			fi
		fi

		# Now, the Gtk2.pm file, it will require dev-perl/gtk2-perl
		# so it implies gtk2 as well. That's why we need another use flag.
		if ! use gtk2-perl; then
			rm -f "${D}/usr/share/fvwm/perllib/FVWM/Module/Gtk2.pm"
		fi
	else
		# Completely wipe it if ! use perl
		rm -rf "${D}/usr/bin/fvwm-perllib" \
			"${D}/usr/share/man/man1/fvwm-perllib.1"
	fi

	# Utility for testing FVWM behaviour by creating a simple window with
	# configurable hints.
	if use debug; then
		dobin "${S}/tests/hints/hints_test"
		newdoc "${S}/tests/hints/README" README.hints
	fi

	# Remove fvwm-convert-2.6 as it does not contain any code.
	rm -f "${D}/usr/bin/fvwm-convert-2.6" \
		"${D}/usr/share/man/man1/fvwm-convert-2.6.1"

	echo "/usr/bin/fvwm" > "${D}/etc/X11/Sessions/${PN}"

	dodoc AUTHORS ChangeLog NEWS README \
		docs/{ANNOUNCE,BUGS,COMMANDS,CONVENTIONS} \
		docs/{DEVELOPERS,error_codes,FAQ,TODO,fvwm.lsm}

	# README file for translucent menus patch.
	use vanilla || dodoc "${FILESDIR}/README.translucency"
}
