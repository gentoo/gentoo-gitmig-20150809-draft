# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Maintainer:  Martin Schlemmer <azarah@cvs.gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/media-video/drip/drip-0.8.1-r3.ebuild,v 1.1 2002/05/26 14:05:33 azarah Exp $

AF_MINOR_VER="$(avifile-config --data-dir | cut -d. -f2)"
S=${WORKDIR}/${P}
DESCRIPTION="Drip - A DVD to DIVX convertor frontend"
SRC_URI="${SRC_URI} http://drip.sourceforge.net/files/${P}.tar.gz"
HOMEPAGE="http://drip.sourceforge.net/"

RDEPEND="gnome-base/gnome-libs
	>=media-video/avifile-0.7.4.20020426-r2
	>=media-libs/a52dec-0.7.3
	>=media-libs/libdvdcss-1.1.1
	>=media-libs/libdvdread-0.9.2
	media-libs/gdk-pixbuf"
	
DEPEND="${RDEPEND}
	dev-lang/nasm
	>=sys-devel/automake-1.5-r1"


src_unpack() {

	unpack ${A}

	# Fix hardcoded path of plugins
	cd ${S}
	cp encoder/plugin-loader.cpp encoder/plugin-loader.cpp.orig
	sed -e "s:/usr/local/lib:/usr/lib:g" \
		encoder/plugin-loader.cpp.orig >encoder/plugin-loader.cpp

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
	export WANT_AUTOMAKE_1_5=1
	aclocal -I macros
	automake --add-missing
	autoconf
}

src_compile() {

	export WANT_AUTOMAKE_1_5=1

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

	insinto /usr/share/pixmaps
	newins ${S}/pixmaps/drip_logo.jpg drip.jpg
	insinto /usr/share/gnome/apps/Multimedia
	doins ${FILESDIR}/drip.desktop
}

