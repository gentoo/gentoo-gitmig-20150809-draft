# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-wm/sawfish/sawfish-1.0.1-r6.ebuild,v 1.14 2004/07/15 01:16:02 agriffis Exp $

IUSE="gtk nls esd gnome"

DESCRIPTION="Extensible window manager using a Lisp-based scripting language"
SRC_URI="mirror://sourceforge/sawmill/${P}.tar.gz"
HOMEPAGE="http://sawmill.sourceforge.net/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc -ppc alpha"

DEPEND="=x11-libs/rep-gtk-0.15*
	>=dev-libs/librep-0.14
	>=media-libs/imlib-1.9.10-r1
	esd? ( >=media-sound/esound-0.2.22 )
	gtk? ( >=media-libs/gdk-pixbuf-0.11.0-r1 )
	gnome? ( >=gnome-base/gnome-core-1.4.0.4-r1
		>=media-libs/gdk-pixbuf-0.11.0-r1 )"

RDEPEND="${DEPEND}
	=x11-libs/gtk+-1*
	nls? ( sys-devel/gettext )"

src_unpack() {
	unpack ${A}

	cd ${S}
	patch -p0 <${FILESDIR}/capplet-crash.patch || die
	#fix buggy Makefile with newer libtool
	patch -p0 <${FILESDIR}/sawfish-${PV}-exec.patch || die

	#update libtool for "relink" bug fix
	libtoolize --copy --force
	aclocal
}

src_compile() {

	local myconf

	use esd \
		&& myconf="--with-esd" \
		|| myconf="--without-esd"

	use gnome \
		&& myconf="${myconf} --with-gnome-prefix=/usr --enable-gnome-widgets --enable-capplet" \
		|| myconf="${myconf} --disable-gnome-widgets --disable-capplet"

	use nls || myconf="${myconf} --disable-linguas"

	use gtk || use gnome \
		&& myconf="${myconf} --with-gdk-pixbuf" \
		|| myconf="${myconf} --without-gdk-pixbuf"

	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--libexecdir=/usr/lib \
		--with-audiofile \
		${myconf} || die

	# see bug #4728
	MAKEOPTS="-j1" emake || die
}

src_install() {

	make DESTDIR=${D} \
		install || die

	use nls || rmdir ${D}/usr/share/locale

	dodoc AUTHORS BUGS COPYING ChangeLog
	dodoc DOC FAQ NEWS README THANKS TODO

	# Add to Gnome CC's Window Manager list
	if use gnome
	then
		insinto /usr/share/gnome/wm-properties
		doins ${FILESDIR}/Sawfish.desktop
	fi
}
