# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/openexr_viewers/openexr_viewers-1.0.1.ebuild,v 1.5 2008/01/30 07:34:18 opfer Exp $

inherit autotools eutils

DESCRIPTION="OpenEXR Viewers"
SRC_URI="http://download.savannah.nongnu.org/releases/openexr/${P}.tar.gz"
HOMEPAGE="http://openexr.com/"

SLOT="0"
LICENSE="BSD"
KEYWORDS="~alpha amd64 hppa ~ia64 ~ppc ~ppc64 ~sparc x86"
IUSE_VIDEO_CARDS="video_cards_nvidia"
IUSE="doc opengl ${IUSE_VIDEO_CARDS}"

RDEPEND="media-libs/ilmbase
	media-libs/openexr
	media-libs/ctl
	media-libs/openexr_ctl
	opengl? ( virtual/opengl
		>=x11-libs/fltk-1.1.0
		video_cards_nvidia? ( media-gfx/nvidia-cg-toolkit ) )"
DEPEND="${RDEPEND}
	!<media-libs/openexr-1.5.0
	dev-util/pkgconfig"

pkg_setup() {
	if use opengl && ! built_with_use x11-libs/fltk opengl ; then
		die "You need OpenGL support in FLTK"
	fi
}

src_unpack() {
	unpack ${A}
	cd "${S}"

	epatch "${FILESDIR}/${PN}-1.0.0-nvidia-automagic.patch"
	AT_M4DIR="m4" eautoreconf
}

src_compile() {
	econf \
		$(use_with opengl fltk-config /usr/bin/fltk-config) \
		$(use_enable video_cards_nvidia nvidia)
	emake || die "emake failed"
}

src_install () {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README

	if use doc ; then
		insinto "/usr/share/doc/${PF}"
		doins doc/*.pdf
	fi
	rm -frv "${D}usr/share/doc/OpenEXR_Viewers"*
}
