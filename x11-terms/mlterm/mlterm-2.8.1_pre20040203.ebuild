# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mlterm/mlterm-2.8.1_pre20040203.ebuild,v 1.1 2004/02/03 13:17:48 usata Exp $

IUSE="truetype gtk gtk2 imlib bidi nls"

S="${WORKDIR}/${PN}"

DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://gentoo/${P/-*_pre/-}.tar.gz"

SLOT="0"
KEYWORDS="~x86"
LICENSE="BSD"

# mlterm itself could use either gdk-pixbuf2, gdk-pixbuf1 or imlib but
# mlconfig requires gtk+-1.2. Hence, I leave gtk+-1.2 inside gtk? clause
# even though you have gtk2 USE flag. (If you build mlterm with
# gdk-pixbuf2 mlterm won't depend on gtk+-1.2 but mlconfig does)
# See also bug 34573
DEPEND="gtk? ( gtk2? ( >=x11-libs/gtk+-2 )
		!gtk2? ( media-libs/gdk-pixbuf )
		=x11-libs/gtk+-1.2* )
	!gtk? ( imlib? ( >=media-libs/imlib-1.9.14 ) )
	truetype? ( =media-libs/freetype-2* )
	bidi? ( >=dev-libs/fribidi-0.10.4 )
	nls? ( sys-devel/gettext )"

src_compile() {
	local myconf imagelib

	if [ -n "`use gtk`" -a -n "`use gtk2`" ] ; then
		imagelib="gdk-pixbuf2"
	elif [ -n "`use gtk`" ] ; then
		imagelib="gdk-pixbuf1"
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
