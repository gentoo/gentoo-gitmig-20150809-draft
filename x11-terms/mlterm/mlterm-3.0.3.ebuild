# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mlterm/mlterm-3.0.3.ebuild,v 1.2 2012/03/28 00:13:20 jer Exp $

EAPI="3"
inherit eutils

IUSE="bidi gtk ibus m17n-lib nls scim static-libs truetype uim"
#IUSE="${IUSE} iiimf"

DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlterm/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~x86"
LICENSE="BSD"

RDEPEND="|| ( sys-libs/libutempter sys-apps/utempter )
	x11-libs/libX11
	x11-libs/libICE
	x11-libs/libSM
	gtk? ( x11-libs/gtk+:2 )
	truetype? ( x11-libs/libXft )
	bidi? ( >=dev-libs/fribidi-0.10.4 )
	ibus? ( >=app-i18n/ibus-1.3 )
	nls? ( virtual/libintl )
	uim? ( >=app-i18n/uim-1.0 )
	scim? ( >=app-i18n/scim-1.4 )
	m17n-lib? ( >=dev-libs/m17n-lib-1.2.0 )"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	nls? ( sys-devel/gettext )"

src_prepare() {
	epatch \
		"${FILESDIR}"/${PN}-2.9.4-uim15-fix.patch \
		"${FILESDIR}"/${PN}-3.0.3-gentoo.diff
}

src_configure() {
	local myconf

	if use gtk ; then
		myconf="${myconf} --with-imagelib=gdk-pixbuf"
	else
		myconf="${myconf} --with-tools=mlclient,mlcc"
	fi

	# iiimf isn't stable enough
	#myconf="${myconf} $(use_enable iiimf)"

	econf --enable-utmp \
		$(use_enable truetype anti-alias) \
		$(use_enable bidi fribidi) \
		$(use_enable ibus) \
		$(use_enable nls) \
		$(use_enable uim) \
		$(use_enable scim) \
		$(use_enable m17n-lib m17nlib) \
		$(use_enable static-libs static) \
		${myconf} || die "econf failed"
}

src_install () {
	emake DESTDIR="${D}" install || die

	use static-libs || find "${ED}" -name '*.la' -exec rm {} +

	doicon contrib/icon/mlterm* || die
	make_desktop_entry mlterm mlterm mlterm-icon TerminalEmulator || die

	dodoc ChangeLog README || die

	docinto ja
	dodoc doc/ja/* || die
	docinto en
	dodoc doc/en/* || die
}
