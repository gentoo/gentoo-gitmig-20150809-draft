# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/libao/libao-0.8.4-r1.ebuild,v 1.6 2004/02/10 01:15:03 vapier Exp $

DESCRIPTION="the audio output library"
HOMEPAGE="http://www.xiph.org/ao/"
SRC_URI="http://www.xiph.org/ao/src/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~sparc ~alpha ~hppa ~amd64"
IUSE="alsa arts esd nas"

RDEPEND="virtual/glibc
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	esd? ( >=media-sound/esound-0.2.22 )
	nas? ( media-libs/nas )"
DEPEND="${RDEPEND}
	>=sys-devel/autoconf-2.58"

src_unpack() {
	unpack ${A}
	cd ${S}/src/plugins/alsa09
	epatch ${FILESDIR}/alsa-1.0.patch
	cd ${S}
	epatch ${FILESDIR}/${P}-esd.patch
	WANT_AUTOCONF=2.5 autoconf || die
	rm ltmain.sh
	libtoolize -c -f || die "libtoolize failed"
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
