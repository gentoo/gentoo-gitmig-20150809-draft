# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-1.1.5.ebuild,v 1.8 2004/08/03 13:06:48 vapier Exp $

inherit kde flag-o-matic gcc
set-kdedir 3.1

DESCRIPTION="aRts, the KDE sound (and all-around multimedia) server/output manager"
HOMEPAGE="http://multimedia.kde.org"
SRC_URI="mirror://kde/stable/3.1.5/src/${P}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="3.1"
KEYWORDS="x86 ~ppc sparc alpha hppa amd64 ia64"
IUSE="alsa oggvorbis artswrappersuid mad"

DEPEND="alsa? ( media-libs/alsa-lib )
	oggvorbis? ( media-libs/libvorbis media-libs/libogg )
	mad? ( media-libs/libmad media-libs/libid3tag )
	media-libs/audiofile
	>=dev-libs/glib-2
	>=x11-libs/qt-3.1.0"

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
}

src_compile() {
	if [ "`gcc-major-version`" == "3" ] ; then
		# GCC 3.1 kinda makes arts buggy and prone to crashes when compiled with
		# these.. Even starting a compile shuts down the arts server
		filter-flags -fomit-frame-pointer -fstrength-reduce
	fi

	#fix bug 13453
	filter-flags "-foptimize-sibling-calls"

	myconf="$myconf `use_with alsa`"
	use oggvorbis || myconf="$myconf --disable-vorbis"
	use mad || myconf="$myconf --disable-libmad"

	kde_src_compile
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
CONFIG_PROTECT=${PREFIX}/share/config" > ${D}/etc/env.d/49kdepaths-3.1.5 # number goes down with version upgrade

	echo "KDEDIR=$PREFIX" > ${D}/etc/env.d/56kdedir-3.1.5 # number goes up with version upgrade

	# used for realtime priority, but off by default as it is a security hazard
	use artswrappersuid && chmod +s ${D}/${PREFIX}/bin/artswrapper

}

pkg_postinst() {

if ! use artswrappersuid; then
	einfo "Run chmod +s ${PREFIX}/bin/artswrapper to let artsd use realtime priority"
	einfo "and so avoid possible skips in sound. However, on untrusted systems this"
	einfo "creates the possibility of a DoS attack that'll use 100% cpu at realtime"
	einfo "priority, and so is off by default. See bug #7883."
	einfo "Or, you can set the local artswrappersuid USE flag to make the ebuild do this."
fi

}
