# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt-unicode/rxvt-unicode-9.10.ebuild,v 1.1 2010/12/13 20:15:59 jer Exp $

EAPI="3"

inherit autotools flag-o-matic

DESCRIPTION="rxvt clone with xft and unicode support"
HOMEPAGE="http://software.schmorp.de/pkg/rxvt-unicode.html"
SRC_URI="http://dist.schmorp.de/rxvt-unicode/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="256-color afterimage iso14755 perl blink truetype +vanilla wcwidth"

# see bug #115992 for modular x deps
RDEPEND="x11-libs/libX11
	x11-libs/libXft
	afterimage? ( || ( media-libs/libafterimage x11-wm/afterstep ) )
	x11-libs/libXrender
	perl? ( dev-lang/perl )
	>=sys-libs/ncurses-5.7-r6"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xproto"

src_prepare() {
	if use wcwidth; then
		ewarn "You enabled wcwidth."
		ewarn "Please note that this is not supported by upstream."
		ewarn "You are at your own if you run into problems."
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
		--disable-pixbuf \
		$(use_enable truetype xft) \
		$(use_enable 256-color) \
		$(use_enable afterimage) \
		$(use_enable perl) \
		$(use_enable blink text-blink) \
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
