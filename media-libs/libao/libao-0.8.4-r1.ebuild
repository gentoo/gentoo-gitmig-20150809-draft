# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libao/libao-0.8.4-r1.ebuild,v 1.3 2004/01/21 11:03:24 raker Exp $

IUSE="alsa arts esd nas"

S=${WORKDIR}/${P}
DESCRIPTION="the audio output library"
SRC_URI="http://www.xiph.org/ao/src/${P}.tar.gz"
HOMEPAGE="http://www.xiph.org/ao/"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
# removing "mips" because of dependency breakage

DEPEND="virtual/glibc
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	esd? ( >=media-sound/esound-0.2.22 )
	nas? ( media-libs/nas )"

src_unpack() {
	unpack ${A}
	cd ${S}/src/plugins/alsa09
	epatch ${FILESDIR}/alsa-1.0.patch
	cd ${S}
	epatch ${FILESDIR}/${P}-esd.patch
	WANT_AUTOCONF_2_5=1 autoconf || die
}

src_compile() {
	econf \
		`use_enable alsa alsa09` \
		`use_enable arts` \
		`use_enable esd` \
		`use_enable nas` \
		--enable-shared \
		--enable-static || die

	# See bug #37218.  Build problems with parallel make.
	emake -j1 || die
}

src_install () {
	make DESTDIR=${D} install || die

	rm -rf ${D}/usr/share/doc
	dodoc AUTHORS CHANGES COPYING README TODO
	dohtml -A c doc/*.html
}
