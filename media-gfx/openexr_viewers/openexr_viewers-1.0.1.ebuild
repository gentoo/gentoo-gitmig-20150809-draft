# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/openexr_viewers/openexr_viewers-1.0.1.ebuild,v 1.13 2010/03/10 03:02:03 sping Exp $

EAPI=2
inherit autotools eutils

DESCRIPTION="OpenEXR Viewers"
SRC_URI="http://download.savannah.gnu.org/releases/openexr/${P}.tar.gz"
HOMEPAGE="http://openexr.com/"

LICENSE="BSD"
SLOT="0"
KEYWORDS="alpha amd64 hppa ia64 ppc ppc64 sparc x86 ~x86-fbsd"
IUSE="doc opengl video_cards_nvidia"

RDEPEND="media-libs/ilmbase
	media-libs/openexr
	media-libs/ctl
	media-libs/openexr_ctl
	opengl? ( virtual/opengl
		>=x11-libs/fltk-1.1.0:1.1[opengl]
		video_cards_nvidia? ( media-gfx/nvidia-cg-toolkit ) )"
DEPEND="${RDEPEND}
	!<media-libs/openexr-1.5.0
	dev-util/pkgconfig"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-1.0.0-nvidia-automagic.patch \
		"${FILESDIR}"/${P}-gcc43.patch \
		"${FILESDIR}"/${P}-gcc44.patch
	AT_M4DIR="m4" eautoreconf
}

src_configure() {
	econf \
		$(use_with opengl fltk-config /usr/bin/fltk-config) \
		$(use_enable video_cards_nvidia nvidia)
}

src_install () {
	emake DESTDIR="${D}" install || die "install failed"
	dodoc AUTHORS ChangeLog NEWS README

	if use doc; then
		insinto "/usr/share/doc/${PF}"
		doins doc/*.pdf
	fi
	rm -frv "${D}usr/share/doc/OpenEXR_Viewers"*
}
