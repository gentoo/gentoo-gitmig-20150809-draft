# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mlterm/mlterm-2.6.3-r2.ebuild,v 1.3 2003/11/29 16:24:26 usata Exp $

IUSE="truetype gnome gtk gtk2 imlib bidi nls"

S=${WORKDIR}/${P}
DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlterm/${P}.tar.gz"

SLOT="0"
KEYWORDS="x86 ppc"
LICENSE="BSD"

DEPEND="gnome? ( gtk? ( gtk2? ( =x11-libs/gtk+-2* ) ) :
			( >=media-libs/gdk-pixbuf-0.18.0 ) )
	!gnome? ( imlib? >=media-libs/imlib-1.9.14 : virtual/x11 )
	=x11-libs/gtk+-1.2*
	truetype? ( >=media-libs/freetype-2.1.2 )
	bidi? ( >=dev-libs/fribidi-0.10.4 )
	nls? ( sys-devel/gettext )"

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

	econf --enable-utmp \
		`use_enable truetype anti-alias` \
		`use_enable bidi fribidi` \
		`use_enable nls`
		--with-imagelib=${imagelib} \
		${myconf} || die "econf failed"
	emake || die
}

src_install () {
	make DESTDIR=${D} install || die
	dodoc ChangeLog LICENCE README
}
