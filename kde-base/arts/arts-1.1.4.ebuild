# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-1.1.4.ebuild,v 1.10 2003/12/28 03:32:32 caleb Exp $
inherit kde flag-o-matic

IUSE="alsa oggvorbis artswrappersuid mad"

set-kdedir 3.1
need-qt 3.1.0

SRC_URI="mirror://kde/stable/3.1.4/src/${P}.tar.bz2"
HOMEPAGE="http://multimedia.kde.org"
DESCRIPTION="aRts, the KDE sound (and all-around multimedia) server/output manager"

KEYWORDS="x86 ppc sparc ~alpha hppa amd64"

DEPEND="alsa? ( media-libs/alsa-lib )
	oggvorbis? ( media-libs/libvorbis media-libs/libogg )
	mad? ( media-libs/libmad media-libs/libid3tag )
	media-libs/audiofile
	>=dev-libs/glib-2"

if [ "${COMPILER}" == "gcc3" ]; then
	# GCC 3.1 kinda makes arts buggy and prone to crashes when compiled with
	# these.. Even starting a compile shuts down the arts server
	filter-flags "-fomit-frame-pointer -fstrength-reduce"
fi

#fix bug 13453
filter-flags "-foptimize-sibling-calls"

SLOT="3.1"
LICENSE="GPL-2 LGPL-2"

use alsa && myconf="$myconf --with-alsa" || myconf="$myconf --without-alsa"
use oggvorbis || myconf="$myconf --disable-vorbis"
use mad || myconf="$myconf --disable-libmad"

# patch to configure.in.in that makes the vorbis, libmad deps optional
# has no version number in its filename because it's the same for all
# arts versions - the patched file hasn't changed in a year's time
PATCHES="$FILESDIR/optional-deps.diff"

src_unpack() {
	kde_src_unpack
	kde_sandbox_patch ${S}/soundserver
	# for the configure.in.in patch, for some reason it's not automatically picked up
	rm $S/configure
	kde_fix_autodetect
	cd ${S}
	use amd64 && epatch ${FILESDIR}/${P}-amd64.patch
}

src_compile() {
	kde_src_compile myconf
	kde_fix_head_instances acinclude.m4 aclocal.m4 admin/cvs.sh admin/libtool.m4 debian/rules
	kde_src_compile configure
	kde_src_compile make
}

src_install() {
	kde_src_install
	dodoc ${S}/doc/{NEWS,README,TODO}

	# moved here from kdelibs so that when arts is installed
	# without kdelibs it's still in the path.
	dodir /etc/env.d
echo "PATH=${PREFIX}/bin
ROOTPATH=${PREFIX}/sbin:${PREFIX}/bin
LDPATH=${PREFIX}/lib
CONFIG_PROTECT=${PREFIX}/share/config" > ${D}/etc/env.d/49kdepaths-3.1.4 # number goes down with version upgrade

	echo "KDEDIR=$PREFIX" > ${D}/etc/env.d/56kdedir-3.1.4 # number goes up with version upgrade

	# used for realtime priority, but off by default as it is a security hazard
	use artswrappersuid && chmod +s ${D}/${PREFIX}/bin/artswrapper

}

pkg_postinst() {

if [ -z "`use artswrappersuid`" ]; then
	einfo "Run chmod +s ${PREFIX}/bin/artswrapper to let artsd use realtime priority"
	einfo "and so avoid possible skips in sound. However, on untrusted systems this"
	einfo "creates the possibility of a DoS attack that'll use 100% cpu at realtime"
	einfo "priority, and so is off by default. See bug #7883."
	einfo "Or, you can set the local artswrappersuid USE flag to make the ebuild do this."
fi

}
