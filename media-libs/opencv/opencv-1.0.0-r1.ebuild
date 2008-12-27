# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/opencv/opencv-1.0.0-r1.ebuild,v 1.5 2008/12/27 01:27:46 gentoofan23 Exp $

EAPI="1"
inherit eutils flag-o-matic autotools

DESCRIPTION="A collection of algorithms and sample code for various computer vision problems."
HOMEPAGE="http://opencv.willowgarage.com/wiki/"
SRC_URI="mirror://sourceforge/${PN}library/${P}.tar.gz"

##If video for linux is enabled, add GPL-2, since it will need to use GPL-2
##stuff, same for v4l
LICENSE="v4l? ( GPL-2 ) xine? ( GPL-2 ) Intel"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="debug demos examples ffmpeg gtk ieee1394 jpeg jpeg2k openexr png python tiff xine v4l zlib"

COMMON_DEPEND="ffmpeg? ( >=media-video/ffmpeg-0.4.9_p20080326 )
	gtk? ( x11-libs/gtk+:2 )
	ieee1394? ( >=sys-libs/libraw1394-1.2.0 media-libs/libdc1394:1 )
	jpeg? ( media-libs/jpeg )
	jpeg2k? ( media-libs/jasper )
	openexr? ( media-libs/openexr )
	png? ( media-libs/libpng:1.2 )
	python? ( >=dev-lang/python-2.3 >=dev-lang/swig-1.3.30 )
	tiff? ( media-libs/tiff )
	xine? ( media-libs/xine-lib )
	zlib? ( sys-libs/zlib )"

DEPEND="${COMMON_DEPEND}
	gtk? ( dev-util/pkgconfig )"
RDEPEND="${COMMON_DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# remove the install-hook that runs ldconfig.
	sed -i '/install-hook:/,/^$/d' Makefile.am

	epatch "${FILESDIR}"/${P}-fixpythonmultilib.patch
	epatch "${FILESDIR}"/${P}-automagicdependencies.patch
	epatch "${FILESDIR}"/${P}-havepngexrdefs.patch
	epatch "${FILESDIR}"/${P}-addoptionalsamples.patch
	epatch "${FILESDIR}"/${P}-cvcapffmpegundefinedsymbols.patch
	epatch "${FILESDIR}"/${P}-ffmpeg-0.4.9_p20080326.patch
	epatch "${FILESDIR}"/${P}-swiginvalidlinkingoptions.patch

	eautoreconf || die "eautoreconf failed"
}

src_compile() {
	use debug && filter-ldflags -O1 -Wl --enable-new-dtags -s

	local myconf="--without-quicktime"
	use python && myconf="${myconf} --with-swig --with-python"

	econf \
		${myconf} \
		$(use_with gtk) \
		$(use_with xine) \
		$(use_with ffmpeg) \
		$(use_with ieee1394 1394libs) \
		$(use_with v4l) \
		$(use_with v4l v4l2) \
		$(use_enable examples samples) \
		$(use_enable debug) \
		$(use_enable demos apps) \
		$(use_enable zlib) \
		$(use_enable jpeg) \
		$(use_enable png) \
		$(use_enable openexr) \
		$(use_enable tiff) \
		$(use_enable jpeg2k jasper)
	emake || die "Emake failed"
}

src_test() {
	emake check || die "Tests failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Install failed"
	dodoc AUTHORS ChangeLog README NEWS TODO
	insinto /usr/share/doc/${P}
	doins -r docs/
}
