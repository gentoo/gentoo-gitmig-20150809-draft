# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mlterm/mlterm-2.8.0_p1-r1.ebuild,v 1.1 2003/10/27 17:53:47 nakano Exp $

IUSE="truetype gtk gtk2 nls imlib nopixbuf bidi"

MY_P="${P/_p?/}"
PATCH_P="${P/_p/pl}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlterm/${MY_P}.tar.gz
	mirror://sourceforge/mlterm/${PATCH_P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="BSD"

DEPEND="virtual/x11
	gtk? ( =x11-libs/gtk+-1.2*
		nls? ( sys-devel/gettext ) )
	|| (
		!nopixbuf? ( media-libs/gdk-pixbuf )
		imlib? ( media-libs/imlib )
		gtk2? ( =x11-libs/gtk+-2* )
		virtual/x11
	)
	truetype? ( =media-libs/freetype-2* )
	bidi? ( dev-libs/fribidi )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${PATCH_P}/${PATCH_P}.patch
}

src_compile() {
	local myconf=""

	if [ ! `use nopixbuf` ] ; then
		myconf="--with-imagelib=gdk-pixbuf1"
	elif [ `use imlib` ] ; then
		myconf="--with-imagelib=imlib"
	elif [ `use gtk2` ] ; then
		myconf="--with-imagelib=gdk-pixbuf2"
	else
		myconf="--with-imagelib="
	fi

	use gtk || myconf="${myconf} --with-tools=mlclient,mlcc"

	econf \
		`use_enable truetype anti-alias` \
		`use_enable nls` \
		`use_enable bidi fribidi` \
		--enable-utmp \
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
