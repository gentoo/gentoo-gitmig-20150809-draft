# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sawfish/sawfish-1.3-r2.ebuild,v 1.2 2004/04/27 17:50:37 pvdabeel Exp $

inherit base eutils gnuconfig

IUSE="gnome readline esd nls"

DESCRIPTION="Extensible window manager using a Lisp-based scripting language"
SRC_URI="mirror://sourceforge/sawmill/${P}.tar.gz"
HOMEPAGE="http://sawmill.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 alpha ppc"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=x11-libs/rep-gtk-0.17
	=dev-libs/librep-0.16*
	>=media-libs/imlib-1.9.10-r1
	media-libs/audiofile
	>=x11-libs/gtk+-2.0.8
	esd? ( >=media-sound/esound-0.2.22 )
	readline? ( >=sys-libs/readline-4.1 )
	nls? ( sys-devel/gettext )
	>=sys-apps/sed-4"


src_unpack() {
	base_src_unpack
	use alpha && gnuconfig_update
	# See bug 31660 for the following patch
	epatch ${FILESDIR}/sawfish-1.3-shading.patch
}

src_compile() {
	local myconf=""

	myconf="${myconf} `use_with esd`"
	myconf="${myconf} `use_with readline`"
	use nls || myconf="${myconf} --disable-linguas"

	if use gnome; then
		myconf="${myconf} --with-gnome-prefix=/usr \
			--enable-gnome-widgets --enable-capplet"
	else
		myconf="${myconf} --disable-gnome-widgets --disable-capplet"
	fi

	# Make sure we include freetype2 headers before freetype1 headers,
	# else Xft2 borks, <azarah@gentoo.org> (13 Dec 2002)
	export C_INCLUDE_PATH="${C_INCLUDE_PATH}:/usr/include/freetype2"
	export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:/usr/include/freetype2"

	econf \
		--enable-themer \
		--with-gdk-pixbuf \
		--with-audiofile \
		${myconf} || die

	# The following two lines allow sawfish to compile with gcc 2.95
	# (see bug 18294)
	sed -i -e 's:REP_CFLAGS=:REP_CFLAGS=-I/usr/include/freetype2 :' Makedefs

	# Parallel build doesn't work
	emake -j1 || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING ChangeLog DOC FAQ NEWS README THANKS TODO OPTIONS

	# Add to Gnome CC's Window Manager list
	if use gnome; then
		insinto /usr/share/gnome/wm-properties
		doins ${S}/Sawfish.desktop
	fi
}
