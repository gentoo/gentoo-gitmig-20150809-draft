# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-3.1.5.ebuild,v 1.3 2004/01/29 12:51:38 agriffis Exp $
inherit kde
#don't inherit  kde-base or kde-dist! it calls need-kde which adds kdelibs to depend!

IUSE="alsa cups ipv6 ssl"
DESCRIPTION="KDE libraries needed by all kde programs"
KEYWORDS="x86 ~ppc ~sparc alpha hppa ~amd64 ia64"
HOMEPAGE="http//www.kde.org/"
SLOT="3.1"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/$PV/src/${P}.tar.bz2"

DEPEND=">=sys-devel/autoconf-2.58
	>=app-arch/bzip2-1.0.1
	>=dev-libs/libxslt-1.0.7
	>=dev-libs/libpcre-3.5
	>=dev-libs/libxml2-2.4.10
	ssl? ( >=dev-libs/openssl-0.9.6 )
	alsa? ( media-libs/alsa-lib virtual/alsa )
	cups? ( >=net-print/cups-1.1.14 )
	>=media-libs/tiff-3.5.5
	app-admin/fam
	virtual/ghostscript
	media-libs/libart_lgpl
	sys-devel/gettext
	>=x11-libs/qt-3.1.0
	~kde-base/arts-1.1.5"

RDEPEND="$DEPEND
	doc? ( ~app-doc/kdelibs-apidocs-$PV )
	app-text/sgml-common
	cups? ( net-print/cups )
	dev-lang/python"

myconf="$myconf --with-distribution=Gentoo --enable-libfam --enable-dnotify"
use ipv6	|| myconf="$myconf --with-ipv6-lookup=no"
use ssl		&& myconf="$myconf --with-ssl-dir=/usr"	|| myconf="$myconf --without-ssl"
use alsa	&& myconf="$myconf --with-alsa"			|| myconf="$myconf --without-alsa"
use cups	&& myconf="$myconf --enable-cups"		|| myconf="$myconf --disable-cups"

use x86 && myconf="$myconf --enable-fast-malloc=full"

set-kdedir $PV

src_unpack() {
	kde_src_unpack
	kde_sandbox_patch ${S}/kio/misc/kpac
	use alpha && cd ${S} && epatch ${FILESDIR}/${P}-kjs-alphaev6-gcc3-workaround.patch
}

src_install() {
	kde_src_install
	dohtml *.html

	# kdelibs-apidocs is provided by kdelibs-apidocs ebuild, kdelibs ebuild
	# shouldn't install anything into kdelibs-apidocs (bug #15102)
	rm -r ${D}/$KDEDIR/share/doc/HTML/en/kdelibs-apidocs
}

