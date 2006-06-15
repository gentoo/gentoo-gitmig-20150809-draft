# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mlterm/mlterm-2.9.3.ebuild,v 1.1 2006/06/15 17:07:18 usata Exp $

inherit eutils flag-o-matic

IUSE="truetype gtk imlib bidi nls uim"
#IUSE="${IUSE} m17n-lib iiimf scim"

DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlterm/${P}.tar.gz"

SLOT="0"
KEYWORDS="~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86"
LICENSE="BSD"

DEPEND="gtk? ( >=x11-libs/gtk+-2 )
	!gtk? ( imlib? ( >=media-libs/imlib-1.9.14 ) )
	truetype? ( =media-libs/freetype-2* )
	bidi? ( >=dev-libs/fribidi-0.10.4 )
	nls? ( sys-devel/gettext )
	uim? ( >=app-i18n/uim-0.3.4.2 )"
#	scim? ( >=app-i18n/scim-1.2.1 )
#	m17n-lib? ( >=dev-libs/m17n-lib-1.2.0 )

src_unpack() {
	unpack ${A}
	cd ${S}/xwindow
	epatch ${FILESDIR}/mlterm-2.9.1-gentoo.diff
}

src_compile() {
	local myconf imagelib

	if use gtk ; then
		imagelib="gdk-pixbuf"
	elif use imlib ; then
		imagelib="imlib"
	fi

	use gtk || myconf="${myconf} --with-tools=mlclient,mlcc"

	# m17n-lib, iiimf and scim aren't stable enough
	#myconf="${myconf} $(use_enable iiimf) $(use_enable m17n-lib m17nlib)"
	#myconf="${myconf} $(use_enable scim)"

	append-ldflags $(bindnow-flags)

	econf --enable-utmp \
		$(use_enable truetype anti-alias) \
		$(use_enable bidi fribidi) \
		$(use_enable nls) \
		$(use_enable uim) \
		--with-imagelib="${imagelib}" \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	make DESTDIR=${D} install || die

	dodoc ChangeLog LICENCE README

	docinto ja
	dodoc doc/ja/*
	docinto en
	dodoc doc/en/*
}
