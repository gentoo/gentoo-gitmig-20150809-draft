# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/mpeg4ip/mpeg4ip-1.1.ebuild,v 1.1 2004/05/21 03:52:12 lv Exp $

DESCRIPTION="MPEG 4 implementation library"

HOMEPAGE="http://www.mpeg4ip.net/"

PV2=`echo $PV | sed s/_rc/RC/`

SRC_URI="mirror://sourceforge/${PN}/${PN}-${PV2}.tar.gz"

LICENSE="MPL-1.1 LGPL-2 GPL-2 LGPL-2.1 BSD UCL MPEG4"

SLOT="0"

KEYWORDS="~x86 ~amd64"
# not 64 bit safe yet

IUSE="ipv6 mmx gtk v4l2"

DEPEND="sys-devel/libtool
		sys-devel/autoconf
		sys-devel/automake
		media-libs/faac
		>=media-sound/lame-3.92
		gtk? ( >=x11-libs/gtk+-2 )
		x86? ( mmx? ( >=dev-lang/nasm-0.98.19 ) )
		media-video/ffmpeg
		media-libs/libid3tag"

S="${WORKDIR}/${PN}-${PV2}"

src_compile() {

	cd ${S}

	local myconf
	myconf=" `use_enable ipv6`
			`use_enable mmx`
			`use_enable v4l2`
			` use_enable ppc`"
	use amd64 && myconf="$myconf --disable-mp4live" && \
		ewarn "mp4live disabled on amd64"

	econf ${myconf} || die "configure failed"

	cd ${S}
	emake || die "make failed"

}

src_install () {

	cd ${S}
	einstall || die "make install failed"

}
