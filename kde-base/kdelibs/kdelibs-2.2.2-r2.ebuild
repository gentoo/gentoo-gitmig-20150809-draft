# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-2.2.2-r2.ebuild,v 1.3 2002/01/12 09:15:55 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde kde.org || die
#don't inherit kde-dist! it calls need-kde which adds kdelibs to depend -> circular deps!

DESCRIPTION="KDE ${PV} - Libraries"
HOMEPAGE="http//www.kde.org/"

# kde.eclass has kdelibs in DEPEND, and we can't have that in here. so we recreate the entire
# DEPEND from scratch.
DEPEND=""
RDEPEND=""

newdepend ">=sys-devel/gcc-2.95.2
		virtual/glibc
		sys-devel/ld.so
		sys-devel/perl
		>=media-libs/audiofile-0.1.9
		>=sys-apps/bzip2-1.0.1
		>=dev-libs/libxslt-1.0.7
		>=dev-libs/libpcre-3.5
		>=dev-libs/libxml2-2.4.10
		ssl? ( >=dev-libs/openssl-0.9.6 )
		alsa? ( >=media-libs/alsa-lib-0.5.9 )
		cups? ( net-print/cups )
		>=media-libs/tiff-3.5.5
		app-admin/fam-oss"

DEPEND="$DEPEND
	sys-devel/make
	sys-devel/autoconf
	sys-devel/automake"

RDEPEND="$RDEPEND
	app-text/sgml-common
	cups? ( net-print/cups )
	dev-lang/python"

myconf="$myconf --enable-final"

qtver-from-kdever $PV
need-qt $selected_version

set-kdedir $PV

src_compile() {
    
	kde_src_compile myconf

	use ipv6	|| myconf="$myconf --with-ipv6-lookup=no"
	use ssl		&& myconf="$myconf --with-ssl-dir=/usr"		|| myconf="$myconf --without-ssl"
	use alsa	&& myconf="$myconf --with-alsa"			|| myconf="$myconf --without-alsa"
	use cups	&& myconf="$myconf --enable-cups"		|| myconf="$myconf --disable-cups"

	kde_src_compile configure make

}

src_install() {
	
	kde_src_install
	
	docinto html
	dodoc *.html
	
	dodir /etc/env.d
	echo "KDEDIR=${KDE2DIR}
PATH=${KDE2DIR}/bin
ROOTPATH=${KDE2DIR}/bin
LDPATH=${KDE2DIR}/lib" > ${D}/etc/env.d/70kdelibs-2.2.2
	
}


