# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/d4x/d4x-2.03.ebuild,v 1.12 2004/07/15 02:43:10 agriffis Exp $

IUSE="nls esd gnome oss"

DESCRIPTION="GTK based download manager for X."
SRC_URI="http://www.krasu.ru/soft/chuchelo/files/${P}.tar.gz"
HOMEPAGE="http://www.krasu.ru/soft/chuchelo/"

KEYWORDS="x86 sparc "
SLOT="0"
LICENSE="Artistic"

DEPEND="=x11-libs/gtk+-1.2*
	=dev-libs/glib-1.2*
	>=media-libs/gdk-pixbuf-0.2.5
	esd? ( >=media-sound/esound-0.2.7 )"


src_unpack() {

	unpack ${A}

	# Use our own $CXXFLAGS
	cd ${S}
	cp configure configure.orig
	sed -e "s:CXXFLAGS=\"-O2\":CXXFLAGS=\"${CXXFLAGS}\":g" \
		configure.orig >configure
}

src_compile() {

	myconf=""
	use nls || myconf="${myconf} --disable-nls"
	use esd || myconf="${myconf} --disable-esd"
	use oss || myconf="${myconf} --disable-oss"

	./configure --host=${HOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--enable-release \
		${myconf} || die

	emake || die
}

src_install () {

	dodir /usr/bin
	dodir /usr/share/d4x

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		install || die

	dodoc AUTHORS COPYING ChangeLog* NEWS PLANS README TODO
	cd ${S}/DOC
	dodoc FAQ* LICENSE NAMES TROUBLES THANKS

	cd ${S}
	insinto /usr/share/pixmaps
	doins *.png *.xpm

	if use gnome ; then
		insinto /usr/share/gnome/apps/Internet
		newins nt.desktop d4x.desktop
	fi
}
