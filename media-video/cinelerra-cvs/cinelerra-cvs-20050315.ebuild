# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinelerra-cvs/cinelerra-cvs-20050315.ebuild,v 1.1 2005/03/18 13:24:56 zypher Exp $

inherit gcc eutils flag-o-matic

export WANT_GCC_3="yes"

#filter-flags "-fPIC -fforce-addr"

RESTRICT="nostrip"

DESCRIPTION="Cinelerra - Professional Video Editor - Unofficial CVS-version"
HOMEPAGE="http://cvs.cinelerra.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="3dnow alsa ffmpeg mmx oss static"

DEPEND="!media-video/cinelerra
	virtual/x11
	virtual/libc
	=sys-devel/gcc-3*
	media-libs/libpng
	media-libs/libdv
	media-video/mjpegtools
	>=sys-libs/libavc1394-0.4.1
	>=sys-libs/libraw1394-0.9.0
	>=media-sound/esound-0.2.34
	>=media-libs/openexr-1.2.1
	!media-video/cinelerra
	x86? ( dev-lang/nasm )"

src_unpack() {
	unpack ${A}
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
	`use_with ffmpeg` \
	|| die "configure failed"
# ./configure --prefix=/usr --enable-debug || die "configure failed"
	make || die "make failed"
}

src_install() {

	make DESTDIR=${D} install || die
	dohtml -a png,html,texi,sdw -r doc/*
}

pkg_postinst () {

einfo "Please note that this is unofficial and somewhat experimental code."
einfo "See cvs.cinelerra.org for a list of changes to the official cinelerra"
einfo "release."
einfo "To change to the blue dot theme, enter settings, choose interface from"
einfo "the pull down list in the upper left and change the theme accordingly."

}
