# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-2.2.2a-r1.ebuild,v 1.8 2003/04/27 13:43:49 danarmak Exp $
inherit kde
#don't inherit kde-dist! it calls need-kde which adds kdelibs to depend -> circular deps!

IUSE="ssl cups ipv6 alsa"
DESCRIPTION="KDE $PV - base libraries needed by all kde programs"
KEYWORDS="x86 sparc "
HOMEPAGE="http//www.kde.org/"
SRC_URI="mirror://kde/2.2.2/src/${PN}-${PV/a/}.tar.bz2"

SLOT="2"
LICENSE="GPL-2 LGPL-2"

S=$WORKDIR/kdelibs-2.2.2

# kde.eclass has kdelibs in DEPEND, and we can't have that in here. so we recreate the entire
# DEPEND from scratch.
DEPEND=""
RDEPEND=""
newdepend ">=sys-devel/gcc-2.95.2
	virtual/glibc
	dev-lang/perl
	>=media-libs/audiofile-0.1.9
	>=sys-apps/bzip2-1.0.1
	>=dev-libs/libxslt-1.0.7
	>=dev-libs/libpcre-3.5
	>=dev-libs/libxml2-2.4.10
	ssl? ( >=dev-libs/openssl-0.9.6 )
	alsa? ( >=media-libs/alsa-lib-0.5.9 >=media-sound/alsa-driver-0.5.9 )
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

qtver-from-kdever $PV
need-qt $selected_version

set-kdedir $PV

#this patch contains security issues backported from kde-3.0.5a.
PATCHES="${FILESDIR}/${P}-gentoo.diff
	${FILESDIR}/${P}-crosside.diff"

#fix 11732 and friends
MAKEOPTS="$MAKEOPTS -j1"

src_unpack() {
	kde_src_unpack
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
	if [ "${PREFIX}" != "/usr/kde/2" ]; then
echo "PATH=${PREFIX}/bin:/usr/kde/2/bin
ROOTPATH=${PREFIX}/bin:/usr/kde/2/bin
LDPATH=${PREFIX}/lib:/usr/kde/2/lib" > ${D}/etc/env.d/70kdelibs-${PV}
	else
echo "PATH=${PREFIX}/bin
ROOTPATH=${PREFIX}/bin
LDPATH=${PREFIX}/lib" > ${D}/etc/env.d/70kdelibs-${PV}
	fi

	echo "KDEDIR=/usr/kde/2" > ${D}/etc/env.d/40kdedir-${PV}
}
