# Copyright 1999-2001 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-2.2.2-r4.ebuild,v 1.7 2002/07/17 07:48:29 danarmak Exp $

inherit kde kde.org || die
#don't inherit kde-dist! it calls need-kde which adds kdelibs to depend -> circular deps!

DESCRIPTION="KDE ${PV} - Libraries"
HOMEPAGE="http//www.kde.org/"

SLOT="2"
LICENSE="GPL-2 LGPL-2"

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

src_unpack() {
    
	base_src_unpack
	
	kde_sandbox_patch ${S}/{arts/soundserver,kio/kpac}
	
}

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
	
	dohtml *.html
	
	dodir /etc/env.d
	
	if [ "$KDE2DIR" != "$KDE2LIBSDIR" ]; then
echo "PATH=${KDE2LIBSDIR}/bin:${KDE2DIR}/bin
ROOTPATH=${KDE2LIBSDIR}/bin:${KDE2DIR}/bin
LDPATH=${KDE2LIBSDIR}/lib:${KDE2DIR}/lib" > ${D}/etc/env.d/70kdelibs-${PV}
	else
echo "PATH=${KDE2LIBSDIR}/bin
ROOTPATH=${KDE2LIBSDIR}/bin
LDPATH=${KDE2LIBSDIR}/lib" > ${D}/etc/env.d/70kdelibs-${PV}
	fi

	echo "KDEDIR=${KDE2DIR}" > ${D}/etc/env.d/40kdedir-${PV}

}


