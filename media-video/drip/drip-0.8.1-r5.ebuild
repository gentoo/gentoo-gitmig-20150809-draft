# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/drip/drip-0.8.1-r5.ebuild,v 1.10 2004/11/01 01:08:07 vapier Exp $

DESCRIPTION="A DVD to DIVX convertor frontend"
HOMEPAGE="http://drip.sourceforge.net/"
SRC_URI="http://drip.sourceforge.net/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86"
IUSE="nls"

RDEPEND="gnome-base/gnome-libs
	>=media-video/avifile-0.7.4.20020426-r2
	>=media-libs/a52dec-0.7.3
	>=media-libs/divx4linux-20020418
	>=media-libs/libdvdcss-1.1.1
	>=media-libs/libdvdread-0.9.2
	media-libs/gdk-pixbuf"
DEPEND="${RDEPEND}
	dev-lang/nasm
	>=sys-devel/automake-1.5-r1"

src_unpack() {
	AF_MINOR_VER="$(avifile-config --data-dir | cut -d. -f2)"
	unpack ${A}

	cd ${S}

	# Fix the problem that if the /dev/dvd symlink is not absolute,
	# drip fails to start.
	patch -p1 < ${FILESDIR}/${P}-fix-dvd-symlink.patch || die

	# Fix hardcoded path of plugins
	cd ${S}
	cp encoder/plugin-loader.cpp encoder/plugin-loader.cpp.orig
	sed -e "s:/usr/local/lib:/usr/lib:g" \
		encoder/plugin-loader.cpp.orig >encoder/plugin-loader.cpp

	# Fix missing #include <stdio.h>
	patch -p1 < ${FILESDIR}/${P}-missing-stdio.patch || die

	# Fix missing #include <stdio.h>
	patch -p1 < ${FILESDIR}/${P}-gcc-3.1.patch || die "Failed gcc-3.1 compatibility patch"

	# Fixup to work with avifile-0.${AF_MINOR_VER}
	cd ${S}/encoder
	for x in encoder.hh main.hh encoder.cpp external.cpp
	do
		cp ${x} ${x}.orig
		sed -e "s:AVIFILE_MINOR_VERSION==6:AVIFILE_MINOR_VERSION==${AF_MINOR_VER}:g" \
			${x}.orig >${x}
	done

	# Fix it to work with the suffix the new avifile introduces.
#	cd ${S}
#	for x in $(find . -name 'Makefile.am') configure.in
#	do
#		cp ${x} ${x}.orig
#		sed -e "s:avifile-config:avifile-config0.${AF_MINOR_VER}:g" \
#			${x}.orig >${x}
#	done

	cd ${S}
	# Remove stale script ... "automake --add-missing" will add it again
	rm -f ${S}/missing
	export WANT_AUTOMAKE=1.5
	aclocal -I macros
	automake --add-missing
	autoconf
}

src_compile() {

	export WANT_AUTOMAKE=1.5

	local myconf
	use nls || myconf="--disable-nls"

	CFLAGS= \
	CXXFLAGS= \
	./configure --host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		--infodir=/usr/share/info \
		--localstatedir=/var/lib \
		--sysconfdir=/etc \
		${myconf} || die

	emake || die
}

src_install() {

	make prefix=${D}/usr \
		mandir=${D}/usr/share/man \
		infodir=${D}/usr/share/info \
		localstatedir=${D}/var/lib \
		sysconfdir=${D}/etc \
		drip_helpdir=${D}/usr/share/gnome/help/drip/C \
		drip_pixmapdir=${D}/usr/share/pixmaps \
		install || die

	# Remove liba52.so.* as ac52dec provides this
	rm ${D}/usr/lib/liba52*

	dodoc ABOUT-NLS AUTHORS COPYING ChangeLog INSTALL NEWS README TODO

	# Custom script for drip to get the *real* dvd device
	# It is a bit rough around the edges, but hopefully will do the trick.
	dobin ${FILESDIR}/dripgetdvd.sh

	insinto /usr/share/pixmaps
	newins ${S}/pixmaps/drip_logo.jpg drip.jpg
	insinto /usr/share/gnome/apps/Multimedia
	doins ${FILESDIR}/drip.desktop
}

