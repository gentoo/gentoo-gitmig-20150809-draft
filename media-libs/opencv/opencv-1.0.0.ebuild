# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/opencv/opencv-1.0.0.ebuild,v 1.3 2008/06/19 03:56:24 mr_bones_ Exp $

inherit eutils

DESCRIPTION="OpenCV is a library of programming functions mainly aimed at real time computer vision."
HOMEPAGE="http://opencvlibrary.sourceforge.net/"
SRC_URI="mirror://sourceforge/opencvlibrary/${P}.tar.gz"

LICENSE="Intel"
SLOT="0"
KEYWORDS="~x86"
IUSE="ffmpeg gtk ieee1394 python swig v4l v4l2 xine"

DEPEND="
	dev-util/pkgconfig
	media-libs/jasper
	media-libs/jpeg
	media-libs/libpng
	media-libs/tiff
	sys-libs/zlib
	ffmpeg?   ( >=media-video/ffmpeg-0.4.9 )
	ieee1394? ( media-libs/libdc1394       )
	ieee1394? ( sys-libs/libraw1394        )
	gtk?      ( >=x11-libs/gtk+-2          )
	python?   ( >=dev-lang/python-2.3      )
	swig?     ( dev-lang/swig              )
	xine?     ( media-libs/xine-lib        )
"
RDEPEND="${DEPEND}"

src_compile() {
	local myconf="--without-quicktime"

	if   use ffmpeg ; then
		## TODO: jmglov 2008/06/18
		## Remove this junk once bug # 227975 is resolved
		ewarn "${PN} currently will not build with ffmpeg support"
		ewarn "Please enable the 'xine' USE flag instead"
		ewarn "Working on this in bug # 227975"
		die "configuration failed; see above"
		## TODO: jmglov 2008/06/18

		myconf="${myconf} --with-ffmpeg --without-xine"
	elif use xine   ; then
		myconf="${myconf} --with-xine --without-ffmpeg"
	else
		die "You must set one of the 'ffmpeg' or 'xine' USE flags"
	fi

	myconf="${myconf} $(use_with ieee1394 1394libs)"
	myconf="${myconf} $(use_with python)"
	myconf="${myconf} $(use_with swig)"
	myconf="${myconf} $(use_with v4l)"

	econf ${myconf} || die "econf failed"

	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog COPYING INSTALL NEWS README THANKS TODO
	dodoc -r docs
}
