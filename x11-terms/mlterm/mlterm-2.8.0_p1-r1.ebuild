# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mlterm/mlterm-2.8.0_p1-r1.ebuild,v 1.4 2003/12/05 08:15:29 usata Exp $

IUSE="truetype gnome gtk gtk2 imlib bidi nls"

MY_P="${P/_p?/}"
PATCH_P="${P/_p/pl}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlterm/${MY_P}.tar.gz
	mirror://sourceforge/mlterm/${PATCH_P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="BSD"

DEPEND="gnome? ( gtk? ( gtk2? ( =x11-libs/gtk+-2* ) ) 
		!gtk? ( >=media-libs/gdk-pixbuf-0.18.0 ) )
	!gnome? ( imlib? ( >=media-libs/imlib-1.9.14 ) )
	gtk? ( =x11-libs/gtk+-1.2* )
	truetype? ( =media-libs/freetype-2* )
	bidi? ( >=dev-libs/fribidi-0.10.4 )
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}
	cd ${S}
	epatch ${WORKDIR}/${PATCH_P}/${PATCH_P}.patch
}

src_compile() {
	local myconf imagelib

	if [ -n "`use gnome`" ] ; then
		if [ -n "`use gtk`" -a -n "`use gtk2`" ] ; then
			imagelib="gdk-pixbuf2"
		else
			imagelib="gdk-pixbuf1"
		fi
	elif [ -n "`use imlib`" ] ; then
		imagelib="imlib"
	fi

	use gtk || myconf="${myconf} --with-tools=mlclient,mlcc"

	econf --enable-utmp \
		`use_enable truetype anti-alias` \
		`use_enable bidi fribidi` \
		`use_enable nls` \
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
