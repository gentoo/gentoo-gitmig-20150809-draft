# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kdelibs/kdelibs-3.1-r3.ebuild,v 1.7 2003/04/27 13:43:49 danarmak Exp $
inherit kde
#don't inherit  kde-base or kde-dist! it calls need-kde which adds kdelibs to depend!

IUSE="alsa cups ipv6 ssl"
DESCRIPTION="KDE libraries needed by all kde programs"
KEYWORDS="~x86 ppc ~sparc ~alpha"
HOMEPAGE="http//www.kde.org/"
SLOT="3.1"
LICENSE="GPL-2 LGPL-2"
SRC_URI="mirror://kde/stable/$PV/src/${P}.tar.bz2"

PATCHES="${FILESDIR}/${P}-bookmark.diff
	${FILESDIR}/${P}-zip.diff
	${FILESDIR}/${P}-libxml2-2.5.2.diff"

# kde.eclass has kdelibs in DEPEND, and we can't have that in here.
# so we recreate the entire DEPEND from scratch.
DEPEND=""
RDEPEND=""
newdepend "dev-lang/perl
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
	=kde-base/arts-1.1.0-r1" # this arts rev is part of the same fix
				 # as kdelibs 3.1-r3

newdepend "/autotools"

RDEPEND="$RDEPEND
	app-text/sgml-common
	cups? ( net-print/cups )
	dev-lang/python
	>=sys-apps/portage-2.0.36" # for #7359

myconf="$myconf --with-distribution=Gentoo --enable-libfam --enable-dnotify"
use ipv6	|| myconf="$myconf --with-ipv6-lookup=no"
use ssl		&& myconf="$myconf --with-ssl-dir=/usr"	|| myconf="$myconf --without-ssl"
use alsa	&& myconf="$myconf --with-alsa"			|| myconf="$myconf --without-alsa"
use cups	&& myconf="$myconf --enable-cups"		|| myconf="$myconf --disable-cups"

use x86 && myconf="$myconf --enable-fast-malloc=full"

qtver-from-kdever ${PV}
need-qt $selected_version

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

pkg_postinst() {

einfo "NOTE: for things to work properly, please upgrade kdebase (if installed) to 3.1-r1
or greater."
einfo "If you have kde 3.0.x installed, please upgrade to kdeils-3.0.5a-r2 and kdebase-3.0.5a-r1.
If they don't have your arch's keywords, edit /etc/env.d/65kdelibs-3.0.*, remove the KDEDIRS=
line and env-update."

}
