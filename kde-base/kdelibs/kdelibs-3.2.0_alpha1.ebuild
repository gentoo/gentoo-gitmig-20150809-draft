# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-3.2.0_alpha1.ebuild,v 1.2 2003/09/12 11:51:24 weeve Exp $
inherit kde

MY_PV=3.1.91
S=${WORKDIR}/${PN}-${MY_PV}

IUSE="alsa cups ipv6 ssl"
DESCRIPTION="KDE libraries needed by all kde programs"
KEYWORDS="~x86 ~ppc -sparc ~alpha ~hppa"
HOMEPAGE="http//www.kde.org/"
SLOT="3.2"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/unstable/${MY_PV}/src/${PN}-${MY_PV}.tar.bz2"

# kde.eclass has kdelibs in DEPEND, and we can't have that in here.
# so we recreate the entire DEPEND from scratch.
#RDEPEND="doc? ( ~app-doc/kdelibs-apidocs-$PV )"
DEPEND="dev-lang/perl
	>=media-libs/audiofile-0.1.9
	>=sys-apps/bzip2-1.0.1
	>=dev-libs/libxslt-1.0.7
	>=dev-libs/libpcre-3.5
	>=dev-libs/libxml2-2.4.10
	ssl? ( >=dev-libs/openssl-0.9.6 )
	alsa? ( >=media-libs/alsa-lib-0.5.9 >=media-sound/alsa-driver-0.5.9 )
	cups? ( >=net-print/cups-1.1.14 )
	>=media-libs/tiff-3.5.5
	app-admin/fam-oss
	app-text/ghostscript
	media-libs/libart_lgpl
	sys-devel/gettext
	~kde-base/arts-1.2.0_alpha1"

newdepend "/autotools"

RDEPEND="$RDEPEND
	app-text/sgml-common
	cups? ( net-print/cups )
	dev-lang/python"


qtver-from-kdever ${PV}
need-qt $selected_version
need-autoconf 2.5

set-kdedir ${PV}

src_unpack() {
	kde_src_unpack
	kde_sandbox_patch ${S}/kio/misc/kpac
	use alpha && cd ${S} && epatch ${FILESDIR}/${P}-kjs-alphaev6-gcc3-workaround.patch
}

src_compile() {

	kde_src_compile myconf

	myconf="$myconf --with-distribution=Gentoo --enable-libfam --enable-dnotify"
	use ipv6	|| myconf="$myconf --with-ipv6-lookup=no"
	use ssl		&& myconf="$myconf --with-ssl-dir=/usr"	|| myconf="$myconf --without-ssl"
	use alsa	&& myconf="$myconf --with-alsa"		|| myconf="$myconf --without-alsa"
	use cups	&& myconf="$myconf --enable-cups"	|| myconf="$myconf --disable-cups"

	use x86 && myconf="$myconf --enable-fast-malloc=full"

	kde_src_compile configure make
}

src_install() {
	kde_src_install
	dohtml *.html

	# kdelibs-apidocs is provided by kdelibs-apidocs ebuild, kdelibs ebuild
	# shouldn't install anything into kdelibs-apidocs (bug #15102)
	rm -r ${D}/$KDEDIR/share/doc/HTML/en/kdelibs-apidocs
}

