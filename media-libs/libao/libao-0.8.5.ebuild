# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libao/libao-0.8.5.ebuild,v 1.18 2005/08/25 22:16:11 vapier Exp $

inherit libtool eutils

DESCRIPTION="the audio output library"
HOMEPAGE="http://www.xiph.org/ao/"
SRC_URI="http://www.xiph.org/ao/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 mips ppc ~ppc-macos ppc64 sparc x86"
IUSE="alsa arts esd nas mmap static"

DEPEND="virtual/libc
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	esd? ( >=media-sound/esound-0.2.22 )
	nas? ( media-libs/nas )"

src_unpack() {
	unpack ${A}
	cd ${S}
	use ppc-macos && epatch ${FILESDIR}/${P}-ppc-macos.patch
	elibtoolize
}

src_compile() {
	# this is called alsa09 even if it is alsa 1.0
	econf \
		`use_enable alsa alsa09` \
		`use_enable mmap alsa09-mmap` \
		`use_enable arts` \
		`use_enable esd` \
		`use_enable nas` \
		--enable-shared \
		`use_enable static` || die

	# See bug #37218.  Build problems with parallel make.
	emake -j1 || die
}

src_install () {
	make DESTDIR=${D} install || die

	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS CHANGES COPYING README TODO
	dohtml -A c doc/*.html
}