# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# Author Dan Armak <danarmak@gentoo.org>
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-2.2.1-r2.ebuild,v 1.3 2001/11/25 15:16:19 danarmak Exp $
. /usr/portage/eclass/inherit.eclass || die
inherit kde-dist || die

DESCRIPTION="${DESCRIPTION}Libraries"

# kde.eclass has kdelibs in DEPEND, and we can't have that in here. so we recreate the entire
# DEPEND from scratch.
COMMONDEPEND=">=sys-devel/gcc-2.95.2
		virtual/glibc
		sys-devel/ld.so
		sys-devel/perl
		>=media-libs/audiofile-0.1.9
		>=sys-apps/bzip2-1.0.1
		>=dev-libs/libpcre-3.4
		>=dev-libs/libxml2-2.4.1
		ssl? ( >=dev-libs/openssl-0.9.6 )
		alsa? ( >=media-libs/alsa-lib-0.5.9 )
		cups? ( net-print/cups )
		>=media-libs/tiff-3.5.5"

DEPEND="$COMMONDEPEND
	sys-devel/make
	sys-devel/autoconf
	sys-devel/automake"

RDEPEND="$COMMONDEPEND
	app-text/sgml-common
	cups? ( net-print/cups )
	dev-lang/python
	~kde-base/kde-env-${PV}"
	
need-qt 2.2.3

BASE=/usr/lib/${P}

src_compile() {

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
	doins ${FILESDIR}/80${P}

}


