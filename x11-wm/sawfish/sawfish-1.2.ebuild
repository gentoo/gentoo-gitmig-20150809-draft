# Copyright 1999-2005 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sawfish/sawfish-1.2.ebuild,v 1.18 2005/06/23 03:51:37 agriffis Exp $

inherit base eutils

IUSE="readline esd nls"

MY_P="${P}-gtk2"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Extensible window manager using a Lisp-based scripting language"
SRC_URI="mirror://sourceforge/sawmill/${MY_P}.tar.gz"
HOMEPAGE="http://sawmill.sourceforge.net/"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 alpha -ppc"

DEPEND=">=dev-util/pkgconfig-0.12.0
	>=x11-libs/rep-gtk-0.17
	>=dev-libs/librep-0.16
	>=media-libs/imlib-1.9.10-r1
	media-libs/audiofile
	>=x11-libs/gtk+-2.0.8
	esd? ( >=media-sound/esound-0.2.22 )
	readline? ( >=sys-libs/readline-4.1 )
	nls? ( sys-devel/gettext )"


src_unpack() {
	base_src_unpack

	cd ${S}; epatch ${FILESDIR}/sawfish-1.2-fullscreen.patch
	# Fixes gtk 2.2 being detected as 1.x
	epatch ${FILESDIR}/sawfish-1.2-gtk+-2.2.patch
}

src_compile() {

	local myconf=""
	use esd && myconf="${myconf} --with-esd"
	use esd || myconf="${myconf} --without-esd"

	use readline && myconf="${myconf} --with-readline"
	use readline || myconf="${myconf} --without-readline"

	use nls || myconf="${myconf} --disable-linguas"

	# Make sure we include freetype2 headers before freetype1 headers, else Xft2
	# borks,
	# <azarah@gentoo.org> (13 Dec 2002)
	export C_INCLUDE_PATH="${C_INCLUDE_PATH}:/usr/include/freetype2"
	export CPLUS_INCLUDE_PATH="${CPLUS_INCLUDE_PATH}:/usr/include/freetype2"

	# The themer is currently broken (must have rep-gtk-0.15
	# installed to get it compiled) - Azarah, 24 Jun 2002
	./configure --host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--libexecdir=/usr/lib \
		--with-gnome-prefix=/usr \
		--enable-gnome-widgets \
		--enable-capplet \
		--disable-themer \
		--with-gdk-pixbuf \
		--with-audiofile \
		${myconf} || die

	# DO NOT USE "emake" !!! - Azarah, 24 Jun 2002
	MAKEOPTS=-j1 make || die
}

src_install() {
	make DESTDIR=${D} install || die
	dodoc AUTHORS BUGS COPYING ChangeLog DOC FAQ NEWS README THANKS TODO

	# Add to Gnome CC's Window Manager list
	insinto /usr/share/gnome/wm-properties
	doins ${FILESDIR}/Sawfish.desktop
}
