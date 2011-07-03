# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/rxvt-unicode/rxvt-unicode-9.12.ebuild,v 1.2 2011/07/03 18:53:24 wired Exp $

EAPI="4"

inherit autotools

DESCRIPTION="rxvt clone with xft and unicode support"
HOMEPAGE="http://software.schmorp.de/pkg/rxvt-unicode.html"
SRC_URI="http://dist.schmorp.de/rxvt-unicode/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris"
IUSE="
	256-color alt-font-width afterimage blink +focused-urgency fading-colors
	+font-styles force-hints iso14755 +mousewheel perl pixbuf truetype unicode3
	+vanilla wcwidth
"

RDEPEND="x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXrender
	>=sys-libs/ncurses-5.7-r6
	afterimage? ( || ( media-libs/libafterimage x11-wm/afterstep ) )
	perl? ( dev-lang/perl )
	pixbuf? ( x11-libs/gdk-pixbuf x11-libs/gtk+:2 )
	kernel_Darwin? ( dev-perl/Mac-Pasteboard )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	x11-proto/xproto"

REQUIRED_USE="vanilla? ( !alt-font-width focused-urgency !force-hints !wcwidth )"

src_prepare() {
	if use kernel_Darwin; then
		cp "${FILESDIR}"/macosx-clipboard src/perl/ || die
	fi
	# fix for prefix not installing properly
	epatch "${FILESDIR}"/${PN}-9.06-case-insensitive-fs.patch

	if ! use afterimage && ! use pixbuf; then
		einfo " + If you want transparency support, please enable either the *pixbuf*"
		einfo "   or the *afterimage* USE flag. Enabling both will default to pixbuf."
	fi

	if use vanilla; then
		ewarn " + You have enabled the vanilla USE flag."
		ewarn "   This means no USE flag controlled patches will be applied."
	else
		ewarn " + You are going to include unsupported third-party bug fixes/features."

		use wcwidth && epatch doc/wcwidth.patch

		# bug #240165
		use focused-urgency || epatch "${FILESDIR}"/${PN}-9.06-no-urgency-if-focused.diff

		# bug #263638
		epatch "${FILESDIR}"/${PN}-9.06-popups-hangs.patch

		# bug #346553
		use force-hints && epatch "${FILESDIR}"/${PN}-9.10-force-hints.patch

		# bug #237271
		epatch "${FILESDIR}"/${PN}-9.05_no-MOTIF-WM-INFO.patch

		use alt-font-width && epatch "${FILESDIR}"/${PN}-9.06-font-width.patch
	fi

	# kill the rxvt-unicode terminfo file - #192083
	sed -i -e "/rxvt-unicode.terminfo/d" doc/Makefile.in || die "sed failed"

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
		$(use_enable mousewheel) \
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
