# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mlterm/mlterm-2.8.1_pre20040423.ebuild,v 1.1 2004/04/25 15:32:47 usata Exp $

IUSE="truetype gtk imlib bidi nls uim"

S="${WORKDIR}/${PN}"

DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://gentoo/${P/-*_pre/-}.tar.gz"

SLOT="0"
KEYWORDS="~x86"
LICENSE="BSD"

DEPEND="gtk? ( >=x11-libs/gtk+-2 )
	!gtk? ( imlib? ( >=media-libs/imlib-1.9.14 ) )
	truetype? ( =media-libs/freetype-2* )
	bidi? ( >=dev-libs/fribidi-0.10.4 )
	nls? ( sys-devel/gettext )
	uim? ( >=app-i18n/uim-0.3.4.2 )"

src_compile() {
	local myconf imagelib

	if [ -n "`use gtk`" ] ; then
		imagelib="gdk-pixbuf"
	elif [ -n "`use imlib`" ] ; then
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
