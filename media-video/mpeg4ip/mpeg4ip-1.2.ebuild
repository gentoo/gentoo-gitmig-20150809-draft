# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg4ip/mpeg4ip-1.2.ebuild,v 1.6 2005/01/17 19:17:00 tester Exp $

inherit eutils

DESCRIPTION="MPEG 4 implementation library"

HOMEPAGE="http://www.mpeg4ip.net/"

SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="MPL-1.1 LGPL-2 GPL-2 LGPL-2.1 BSD UCL MPEG4"

SLOT="0"

KEYWORDS="~x86 ~amd64"

IUSE="ipv6 mmx X v4l2 xvid nas alsa esd arts"

RDEPEND=">=media-libs/faac-1.20.1
	>=media-sound/lame-3.92
	media-libs/libsdl
	X? ( >=x11-libs/gtk+-2 )
	media-libs/libid3tag
	xvid? ( media-libs/xvid )
	nas? ( media-libs/nas virtual/x11 )
	alsa? ( media-libs/alsa-lib )
	arts? ( kde-base/arts )
	esd? ( media-sound/esound )"

DEPEND="${RDEPEND}
	sys-devel/libtool
	sys-devel/autoconf
	sys-devel/automake
	x86? ( mmx? ( >=dev-lang/nasm-0.98.19 ) )"


pkg_setup() {
	if grep -q /usr/lib/libmp4v2.la /usr/lib/libfaac.la; then
		eerror "libfaac is compiled against libmp4v2"
		eerror "Please remove faad2 and mpeg4ip and recompile faac"
		die
	fi

}

src_unpack() {
	unpack ${A}
	cd ${S}

	# This will break building on gcc 3.4 and 4.0
	sed -i -e 's/-Wmissing-prototypes//g' -e 's/-Werror//g' configure

	epatch ${FILESDIR}/mpeg4ip-1.2-mp4encode-template-path.patch
}

src_compile() {
	cd ${S}

	local myconf
	myconf=" --datadir=/usr/share/mpeg4ip
			$(use_enable ipv6)
			$(use_enable mmx)
			$(use_enable ppc)
			$(use_enable nas)
			$(use_enable esd)
			$(use_enable alsa)
			$(use_enable arts)
			$(use_enable X gtk-glib)
			$(use_enable X player)
			$(use_enable X mp4live)
			$(use_enable v4l2)"

	# ffmpeg support doesnt build even on gcc 3.3
	# and the configure script is broken so --disable doesnt work
	sed -i -e 's/have_ffmpeg=true/have_ffmpeg=false/' configure

	econf ${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install () {
	cd ${S}
	make install DESTDIR="${D}" || die "make install failed"

	# Remove version lines..

	grep -v '\(PACKAGE\)\|\(VERSION\)' ${D}/usr/include/mpeg4ip.h \
		> ${D}/usr/include/mpeg4ip.h.modified
	mv ${D}/usr/include/mpeg4ip.h.modified ${D}/usr/include/mpeg4ip.h

	grep -v '\(PACKAGE\)\|\(VERSION\)' ${D}/usr/include/mpeg4ip_config.h \
		> ${D}/usr/include/mpeg4ip_config.h.modified
	mv ${D}/usr/include/mpeg4ip_config.h.modified \
		${D}/usr/include/mpeg4ip_config.h

	dodoc doc/MPEG4IP_Guide.pdf doc/*txt AUTHORS COPYING TODO

	dohtml doc/*.html FEATURES.html || die

	docinto ietf
	dodoc doc/ietf/*.txt || die

	docinto mcast
	dodoc doc/mcast/mcast.txt doc/mcast/mcast_example doc/mcast/playlist_example || die

}
