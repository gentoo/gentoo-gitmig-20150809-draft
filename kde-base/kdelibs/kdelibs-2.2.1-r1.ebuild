# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-2.2.1-r1.ebuild,v 1.1 2001/10/03 17:10:16 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}Libraries"

# kde.eclass has kdelibs in DEPEND, and we can't have that in here. so we recreate the entire
# DEPEND from scratch.
COMMONDEPEND=">=sys-devel/gcc-2.95.2
			virtual/glibc
			sys-deve/ld.so
			sys-devel/perl
			>=media-libs/audiofile-0.1.9
			>=x11-libs/qt-x11-2.3.0
			>=sys-apps/bzip2-1.0.1
			>=dev-libs/libpcre-3.4
			>=gnome-libs/libxml2-2.4.1
			ssl? ( >=dev-libs/openssl-0.9.6 )
			alsa? ( >=media-libs/alsa-lib-0.5.9 )
			cups? ( net-print/cups )
			>=media-libs/tiff-3.5.5"

DEPEND="$COMMONDEPEND
		sys-devel/make
		sys-devel/autoconf
		sys-devel/automake"

RDEPEND="$COMMONDEPEND
		~kde-base/kde-env-${PV}
		app-text/sgml-common
		cups? ( net-print/cups )
		dev-lang/python"

src_compile() {

	kde_src_compile myconf

	myconf="$myconf --with-ipv6-lookup=no --disable-libafm"
	use ssl		&& myconf="$myconf --with-ssl-dir=/usr"		|| myconf="$myconf --without-ssl"
	use alsa	&& myconf="$myconf --with-alsa"				|| myconf="$myconf --without-alsa"
	use cups	&& myconf="$myconf --enable-cups"			|| myconf="$myconf --disable-cups"

	kde_src_compile configure make

}

src_install() {

	kde_src_install

	docinto html
	dodoc *.html

}


