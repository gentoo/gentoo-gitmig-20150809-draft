# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/mlterm/mlterm-2.8.0.ebuild,v 1.1 2003/10/05 21:42:48 usata Exp $

IUSE="truetype gtk gtk2 gnome imlib nls"

MY_P="${P/_/-}"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="A multi-lingual terminal emulator"
HOMEPAGE="http://mlterm.sourceforge.net/"
SRC_URI="mirror://sourceforge/mlterm/${MY_P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~ppc"
LICENSE="BSD"

DEPEND="virtual/x11
	gtk? ( gtk2? >=x11-libs/gtk+-2.0.8 : >=media-libs/gdk-pixbuf-0.18.0 )
	!gtk? ( imlib? >=media-libs/imlib-1.9.14 )
	truetype? ( >=media-libs/freetype-2.1.2 )
	nls? ( >=dev-libs/fribidi-0.10.4 )"

src_compile() {

	local myconf

	use imlib && myconf="${myconf} --with-imagelib=imlib"
	use gtk && myconf="${myconf} --with-imagelib=gdk-pixbuf1"
	use gtk2 && myconf="${myconf} --with-imagelib=gdk-pixbuf2"

	econf `use_enable truetype anti-alias` \
		`use_enable nls` \
		`use_enable nls fribidi` \
		--enable-utmp \
		${myconf} || die "econf failed"
	emake || die "emake failed"
}

src_install () {

	#dodir /etc/mlterm
	#dodir /usr/bin
	einstall || die

	dodoc ChangeLog LICENCE README
}
