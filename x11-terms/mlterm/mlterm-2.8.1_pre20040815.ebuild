# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mlterm/mlterm-2.8.1_pre20040815.ebuild,v 1.3 2004/09/07 09:06:31 usata Exp $

IUSE="truetype gtk imlib bidi nls uim"

S="${WORKDIR}/${PN}"

DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://gentoo/${P/-*_pre/-}.tar.gz
	http://dev.gentoo.org/~usata/distfiles/${P/-*_pre/-}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc"
LICENSE="BSD"

DEPEND="gtk? ( >=x11-libs/gtk+-2 )
	!gtk? ( imlib? ( >=media-libs/imlib-1.9.14 ) )
	truetype? ( =media-libs/freetype-2* )
	bidi? ( >=dev-libs/fribidi-0.10.4 )
	nls? ( sys-devel/gettext )
	uim? ( >=app-i18n/uim-0.3.4.2 )"

src_compile() {
	local myconf imagelib

	if use gtk ; then
		imagelib="gdk-pixbuf"
	elif use imlib ; then
		imagelib="imlib"
	fi

	use gtk || myconf="${myconf} --with-tools=mlclient,mlcc"

	econf --enable-utmp \
		`use_enable truetype anti-alias` \
		`use_enable bidi fribidi` \
		`use_enable nls` \
		`use_enable uim` \
		--with-imagelib=${imagelib} \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {
	einstall || die

	dodoc ChangeLog LICENCE README

	docinto ja
	dodoc doc/ja/*
	docinto en
	dodoc doc/en/*
}
