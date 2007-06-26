# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/DirectFB-extra/DirectFB-extra-0.9.25.ebuild,v 1.6 2007/06/26 01:52:32 mr_bones_ Exp $

inherit eutils

DESCRIPTION="Extra image/video/font providers and graphics/input drivers for DirectFB"
HOMEPAGE="http://www.directfb.org/"
SRC_URI="http://directfb.org/download/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc -sparc x86"
IUSE="mmx imlib quicktime mpeg flash xine"

RDEPEND=">=dev-libs/DirectFB-${PV}
	imlib? ( media-libs/imlib2 )
	quicktime? ( virtual/quicktime )
	mpeg? ( media-libs/libmpeg3 )
	flash? ( media-libs/libflash )
	xine? ( media-libs/xine-lib )"
#	avi? ( media-video/avifile )
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-CFLAGS.patch
	sed -i \
		-e 's:libmpeg3\.h:libmpeg3/libmpeg3.h:g' \
		configure interfaces/IDirectFBVideoProvider/idirectfbvideoprovider_libmpeg3.c
}

src_compile() {
	#	$(use_enable avi avifile)
	econf \
		$(use_enable mmx) \
		$(use_enable imlib imlib2) \
		$(use_enable quicktime openquicktime) \
		$(use_enable mpeg libmpeg3) \
		$(use_enable flash) \
		$(use_enable xine) \
		--disable-avifile \
		|| die
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc AUTHORS ChangeLog NEWS README
}
