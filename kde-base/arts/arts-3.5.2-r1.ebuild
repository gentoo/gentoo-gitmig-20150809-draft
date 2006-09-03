# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-3.5.2-r1.ebuild,v 1.8 2006/09/03 09:57:02 kloeri Exp $

inherit kde flag-o-matic eutils
set-kdedir 3.5

MY_PV=1.5.2
S=${WORKDIR}/${PN}-${MY_PV}

RESTRICT="test"

DESCRIPTION="aRts, the KDE sound (and all-around multimedia) server/output manager"
HOMEPAGE="http://multimedia.kde.org/"
SRC_URI="mirror://kde/stable/${PV}/src/${PN}-${MY_PV}.tar.bz2"
#SRC_URI="mirror://kde/stable/3.5/src/${PN}-${MY_PV}.tar.bz2"
LICENSE="GPL-2 LGPL-2"

SLOT="3.5"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="alsa esd artswrappersuid jack mp3 nas vorbis"

RDEPEND="$(qt_min_version 3.3)
	>=dev-libs/glib-2
	alsa? ( media-libs/alsa-lib )
	vorbis? ( media-libs/libogg
	          media-libs/libvorbis )
	esd? ( media-sound/esound )
	jack? ( >=media-sound/jack-audio-connection-kit-0.90 )
	mp3? ( media-libs/libmad )
	nas? ( media-libs/nas )
	media-libs/audiofile"

DEPEND="${RDEPEND}
	dev-util/pkgconfig"

PATCHES="${FILESDIR}/arts-1.3.2-alsa-bigendian.patch
	${FILESDIR}/arts-1.5.0-bindnow.patch
	${FILESDIR}/arts-1.2.x.diff"

src_unpack() {
	kde_src_unpack

	# Alternative to arts-1.4-mcopidl.patch, make sure that flags are supported
	# before trying to use them, for non-GCC, vanilla GCC or GCC 4.1 compilers
	local nosspflags

	nosspflags="$(test-flags -fno-stack-protector -fno-stack-protector-all)"
	sed -i -e "s:KDE_CXXFLAGS =\(.*\):KDE_CXXFLAGS = \1 ${nosspflags}:" \
		${S}/mcopidl/Makefile.am

	# Fix libao/gaim problems with aRTs. See bug #116290.
	epatch "${FILESDIR}/arts-1.5.0-check_tmp_dir.patch"
}

src_compile() {
	myconf="$(use_enable alsa) $(use_enable vorbis)
	        $(use_enable mp3 libmad) $(use_with jack)
	        $(use_with esd) $(use_with nas)
		--with-audiofile --without-mas"

	#fix bug 13453
	filter-flags -foptimize-sibling-calls

	# breaks otherwise <gustavoz>
	use sparc && export CFLAGS="-O1" && export CXXFLAGS="-O1"

	export BINDNOW_FLAGS="$(bindnow-flags)"

	kde_src_compile
}

src_install() {
	kde_src_install

	# moved here from kdelibs so that when arts is installed
	# without kdelibs it's still in the path.
	# List all the multilib libdirs
	local libdirs
	for libdir in $(get_all_libdirs); do
		libdirs="${libdirs}:${PREFIX}/${libdir}"
	done

	dodir /etc/env.d
echo "PATH=${PREFIX}/bin
ROOTPATH=${PREFIX}/sbin:${PREFIX}/bin
LDPATH=${libdirs:1}
CONFIG_PROTECT=\"${PREFIX}/share/config ${PREFIX}/env ${PREFIX}/shutdown\"" > ${D}/etc/env.d/45kdepaths-3.5 # number goes down with version upgrade

	# used for realtime priority, but off by default as it is a security hazard
	use artswrappersuid && chmod u+s ${D}/${PREFIX}/bin/artswrapper
}

pkg_postinst() {
	if ! use artswrappersuid ; then
		einfo "Run chmod u+s ${PREFIX}/bin/artswrapper to let artsd use realtime priority"
		einfo "and so avoid possible skips in sound. However, on untrusted systems this"
		einfo "creates the possibility of a DoS attack that'll use 100% cpu at realtime"
		einfo "priority, and so is off by default. See bug #7883."
		einfo "Or, you can set the local artswrappersuid USE flag to make the ebuild do this."
	fi
}
