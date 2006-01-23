# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinelerra-cvs/cinelerra-cvs-20051005.ebuild,v 1.3 2006/01/23 09:29:52 lu_zero Exp $

inherit toolchain-funcs eutils flag-o-matic

#filter-flags "-fPIC -fforce-addr"

RESTRICT="nostrip"

DESCRIPTION="Cinelerra - Professional Video Editor - Unofficial CVS-version"
HOMEPAGE="http://cvs.cinelerra.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="3dnow alsa esd mmx oss static"

RDEPEND="!media-video/cinelerra
	virtual/x11
	media-libs/libpng
	media-libs/libdv
	media-libs/faad2
	media-libs/faac
	x86? ( media-libs/x264-svn )
	media-libs/libiec61883
	media-video/mjpegtools
	>=sys-libs/libavc1394-0.5.0
	>=sys-libs/libraw1394-0.9.0
	esd? ( >=media-sound/esound-0.2.34 )
	>=media-libs/openexr-1.2.2
	>=media-libs/libvorbis-1.1.0
	>=media-libs/libogg-1.1
	>=media-libs/libtheora-1.0_alpha4-r1
	!media-video/cinelerra"

DEPEND="${RDEPEND}
	x86? ( dev-lang/nasm )"

pkg_setup() {
	if [[ "$(gcc-major-version)" -lt "3" ]]; then
		die "You must use gcc 3 or better."
	fi
}

src_unpack() {
	unpack ${A}
	use amd64 && epatch ${FILESDIR}/${PV}-nox264.patch
}

src_compile() {
	cd ${S}
	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.5

	cd ${S}
	./autogen.sh
	econf \
	`use_enable static` \
	`use_enable alsa` \
	`use_enable oss` \
	`use_enable mmx` \
	`use_enable 3dnow` \
	|| die "configure failed"
	make || die "make failed"
}

src_install() {

	make DESTDIR=${D} install || die
	dohtml -a png,html,texi,sdw -r doc/*
	# workaround
	rm -fR ${D}/usr/include
}

pkg_postinst () {

einfo "Please note that this is unofficial and somewhat experimental code."
einfo "See cvs.cinelerra.org for a list of changes to the official cinelerra"
einfo "release."
einfo "The blue dot theme has not (yet) been merged into the new release."
}
