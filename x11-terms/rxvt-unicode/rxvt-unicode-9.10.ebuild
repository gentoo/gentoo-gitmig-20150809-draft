# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt-unicode/rxvt-unicode-9.10.ebuild,v 1.9 2011/04/23 18:53:15 armin76 Exp $

EAPI="3"

inherit autotools flag-o-matic

DESCRIPTION="rxvt clone with xft and unicode support"
HOMEPAGE="http://software.schmorp.de/pkg/rxvt-unicode.html"
SRC_URI="http://dist.schmorp.de/rxvt-unicode/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="256-color afterimage blink fading-colors +font-styles force-hints iso14755 perl pixbuf truetype unicode3 +vanilla wcwidth"

# see bug #115992 for modular x deps
RDEPEND="x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXrender
	>=sys-libs/ncurses-5.7-r6
	afterimage? ( || ( media-libs/libafterimage x11-wm/afterstep ) )
	perl? ( dev-lang/perl )
	pixbuf? ( x11-libs/gdk-pixbuf x11-libs/gtk+:2 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xproto"

src_prepare() {
	if ! use afterimage && ! use pixbuf; then
		einfo
		einfo "If you want transparency support, please enable either the *pixbuf*"
		einfo "or the *afterimage* USE flag. Enabling both will default to pixbuf."
		einfo
	fi

	if use wcwidth || use force-hints; then
		ewarn
		ewarn "You enabled wcwidth or force-hints or both."
		ewarn "Please note that these are not supported by upstream."
		ewarn "You are at your own if you run into problems."
		ewarn
	fi

	local tdir=/usr/share/terminfo

	# kill the rxvt-unicode terminfo file - #192083
	sed -i -e "/rxvt-unicode.terminfo/d" doc/Makefile.in ||
		die "sed failed"

	use wcwidth && epatch doc/wcwidth.patch

	# bug #240165
	epatch "${FILESDIR}"/${PN}-9.06-no-urgency-if-focused.diff

	# bug #263638
	epatch "${FILESDIR}"/${PN}-9.06-popups-hangs.patch

	# bug #346553
	use force-hints && epatch "${FILESDIR}"/${PN}-9.10-force-hints.patch

	# bug #237271
	if ! use vanilla; then
		ewarn "You are going to include third-party bug fixes/features."
		ewarn "They came without any warranty and are not supported by the"
		ewarn "Gentoo community."
		epatch "${FILESDIR}"/${PN}-9.05_no-MOTIF-WM-INFO.patch
		epatch "${FILESDIR}"/${PN}-9.06-font-width.patch
	fi

	eautoreconf
}

src_configure() {
	local myconf=''

	use iso14755 || myconf='--disable-iso14755'

	econf --enable-everything \
		$(use_enable 256-color) \
		$(use_enable afterimage) \
		$(use_enable blink text-blink) \
		$(use_enable fading-colors fading) \
		$(use_enable font-styles) \
		$(use_enable perl) \
		$(use_enable pixbuf) \
		$(use_enable truetype xft) \
		$(use_enable unicode3) \
		${myconf}
}

src_compile() {
	emake || die "emake failed"

	sed -i \
		-e 's/RXVT_BASENAME = "rxvt"/RXVT_BASENAME = "urxvt"/' \
		"${S}"/doc/rxvt-tabbed || die "tabs sed failed"
}

src_install() {
	make DESTDIR="${D}" install || die

	dodoc README.FAQ Changes
	cd "${S}"/doc
	dodoc README* changes.txt etc/* rxvt-tabbed
}
