# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/arts/arts-3.4.0.ebuild,v 1.5 2005/03/18 16:18:28 morfic Exp $

inherit kde flag-o-matic eutils
set-qtdir 3
set-kdedir 3.4

MY_PV=1.4.0
S=${WORKDIR}/${PN}-${MY_PV}

DESCRIPTION="aRts, the KDE sound (and all-around multimedia) server/output manager"
HOMEPAGE="http://multimedia.kde.org/"
SRC_URI="mirror://kde/stable/3.4/src/${PN}-${MY_PV}.tar.bz2"

LICENSE="GPL-2 LGPL-2"
SLOT="3.4"
KEYWORDS="~x86 ~amd64 ~sparc ~ppc"
IUSE="alsa oggvorbis esd artswrappersuid jack mad hardened"

DEPEND="alsa? ( media-libs/alsa-lib virtual/alsa )
	oggvorbis? ( media-libs/libvorbis media-libs/libogg )
	esd? ( media-sound/esound )
	jack? ( media-sound/jack-audio-connection-kit )
	mad? ( media-libs/libmad media-libs/libid3tag )
	media-libs/audiofile
	>=dev-libs/glib-2
	>=x11-libs/qt-3.3"

src_unpack() {
	kde_src_unpack
	epatch ${FILESDIR}/1.3.0-jack-configure.in.in.patch
	epatch ${FILESDIR}/arts-1.3.2-alsa-bigendian.patch

	if (is-flag -fstack-protector || is-flag -fstack-protector-all || use hardened); then
		epatch ${FILESDIR}/arts-1.4-mcopidl.patch
	fi

	# for the configure.in.in patch
	make -f admin/Makefile.common || die
}

src_compile() {
	#fix bug 13453
	filter-flags -foptimize-sibling-calls

	#fix bug 41980
	use sparc && filter-flags -fomit-frame-pointer

	myconf="$myconf $(use_enable alsa) $(use_enable oggvorbis vorbis) $(use_enable mad libmad) $(use_enable jack)"

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
CONFIG_PROTECT=\"${PREFIX}/share/config ${PREFIX}/env ${PREFIX}/shutdown\"" > ${D}/etc/env.d/46kdepaths-3.4 # number goes down with version upgrade

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
