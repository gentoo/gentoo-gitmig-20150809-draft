# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/cinelerra-cvs/cinelerra-cvs-20040917.ebuild,v 1.1 2004/09/18 14:20:39 zypher Exp $

inherit gcc eutils flag-o-matic

export WANT_GCC_3="yes"

filter-flags "-fPIC -fforce-addr"

RESTRICT="nostrip"

DESCRIPTION="Cinelerra - Professional Video Editor - Unofficial CVS-version"
HOMEPAGE="http://cvs.cinelerra.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="3dnow alsa ffmpeg mmx oss static x86"

DEPEND="virtual/x11
	virtual/libc
	=sys-devel/gcc-3*
	dev-lang/nasm
	media-libs/libpng
	>=sys-libs/libavc1394-0.4.1
	>=sys-libs/libraw1394-0.9.0
	>=media-libs/openexr-1.2.1"

src_compile() {
	cd ${S}
	export WANT_AUTOMAKE=1.7
	export WANT_AUTOCONF=2.58

	cd ${S}/libsndfile
	libtoolize --force
	autoheader
	aclocal
	automake --foreign --add-missing
	autoconf
	cd ${S}
	./autogen.sh

	econf \
	`use_enable x86` \
	`use_enable mmx` \
	`use_enable 3dnow` \
	`use_enable static` \
	`use_enable alsa` \
	`use_enable oss` \
	`use_with ffmpeg` \
	|| die "configure failed"

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
