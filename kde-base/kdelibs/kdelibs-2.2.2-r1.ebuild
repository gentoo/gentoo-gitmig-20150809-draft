# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-2.2.2-r1.ebuild,v 1.1 2001/12/29 17:41:37 danarmak Exp $
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
	dev-lang/python
	~kde-base/kde-env-${PV}"

BASE=/usr/kde/2

myconf="$myconf --enable-final"

qtver-from-kdever $PV
need-qt $selected_version

src_compile() {
    
	#separate artsd
	#cd ${S}
	#cp subdirs subdirs.orig
	#cat subdirs.orig | grep -v arts > subdirs

	kde_src_compile myconf

	myconf="$myconf --disable-libafm"
	use ipv6	|| myconf="$myconf --with-ipv6-lookup=no"
	use ssl		&& myconf="$myconf --with-ssl-dir=/usr"		|| myconf="$myconf --without-ssl"
	use alsa	&& myconf="$myconf --with-alsa"			|| myconf="$myconf --without-alsa"
	use cups	&& myconf="$myconf --enable-cups"		|| myconf="$myconf --disable-cups"
	myconf="$myconf --prefix=${BASE}"
	
	kde_src_compile configure make

}

src_install() {
	
	kde_src_install
	
	docinto html
	dodoc *.html
	
	insinto /etc/env.d
	doins ${FILESDIR}/70kdelibs2

}


