# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-video/drip/drip-0.8.2_pre1.ebuild,v 1.1 2002/08/13 21:32:38 azarah Exp $

inherit libtool

MY_P="${P/_}"
S=${WORKDIR}/${MY_P}
DESCRIPTION="Drip - A DVD to DIVX convertor frontend"
SRC_URI="http://drip.sourceforge.net/files/${MY_P}.tar.gz"
HOMEPAGE="http://drip.sourceforge.net/"

RDEPEND="gnome-base/gnome-libs
	>=media-video/avifile-0.7.4.20020426-r2
	>=media-libs/a52dec-0.7.3
	>=media-libs/divx4linux-20020418
	>=media-libs/libdvdcss-1.1.1
	>=media-libs/libdvdread-0.9.2
	>=media-libs/libao-0.8.3
	media-libs/libmpeg2
	media-libs/gdk-pixbuf"
	
DEPEND="${RDEPEND}
	dev-lang/nasm
	>=sys-devel/automake-1.5-r1"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

src_unpack() {

	unpack ${A}

	# Fix the problem that if the /dev/dvd symlink is not absolute,
	# drip fails to start.
	cd ${S} ; patch -p1 < ${FILESDIR}/${PN}-0.8.1-fix-dvd-symlink.patch || die

	# Fix hardcoded path of plugins
	cd ${S}
	cp encoder/plugin-loader.cpp encoder/plugin-loader.cpp.orig
	sed -e "s:/usr/local/lib:/usr/lib:g" \
		encoder/plugin-loader.cpp.orig >encoder/plugin-loader.cpp

	# Remove stale script ... "automake --add-missing" will add it again
	cd ${S} ; rm -f ${S}/missing
	export WANT_AUTOMAKE_1_5=1
	aclocal -I macros
	automake --add-missing
	autoconf
}

src_compile() {

	elibtoolize

	local myconf=""
	
	use nls || myconf="${myconf} --disable-nls"

	use x86 && myconf="${myconf} --without-pic"

	# Do not use custom CFLAGS !!!
	unset CFLAGS CXXFLAGS
	
	econf ${myconf} || die
			
	make || die
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
#	rm ${D}/usr/lib/liba52*
	# Remove libao*, as media-libs/libao provide it
	rm ${D}/usr/lib/libao.{a,la,so}
	# Also do not have anything of libvo but required
	rm ${D}/usr/lib/libvo.{a,la,so}

	dodoc AUTHORS BUG-REPORT.TXT COPYING ChangeLog NEWS README TODO

	# Custom script for drip to get the *real* dvd device
	# It is a bit rough around the edges, but hopefully will do the trick.
	dobin ${FILESDIR}/dripgetdvd.sh

	insinto /usr/share/pixmaps
	newins ${S}/pixmaps/drip_logo.jpg drip.jpg
	insinto /usr/share/gnome/apps/Multimedia
	doins ${FILESDIR}/drip.desktop
}

