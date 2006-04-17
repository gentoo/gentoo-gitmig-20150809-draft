# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/amarok/amarok-1.4_beta3-r2.ebuild,v 1.3 2006/04/17 20:29:01 corsair Exp $

LANGS="az bg br ca cs cy da de el en_GB es et fi fr ga gl he hi hu is it ja km
ko lt nb nl nn pa pl pt pt_BR ro ru rw sl sr sr@Latn sv ta tg th tr uk uz xx
zh_CN zh_TW"
LANGS_DOC="da de es et fr it nl pt pt_BR ru sv"

USE_KEG_PACKAGING=1

inherit kde eutils flag-o-matic

PKG_SUFFIX="c"

MY_PV="${PV/_rc/_RC}"
MY_PV="${MY_PV/_beta/-beta}${PKG_SUFFIX}"
S="${WORKDIR}/${PN}-${MY_PV/_RC*/}"

DESCRIPTION="amaroK - the audio player for KDE."
HOMEPAGE="http://amarok.kde.org/"

if [[ ${MY_PV} == ${MY_PV/_RC*/} ]]; then
	SRC_URI="mirror://sourceforge/amarok/${PN}-${MY_PV}.tar.bz2"
else
	RESTRICT="nomirror"
	SRC_URI="http://rokymotion.pwsp.net/nightly-builds/${MY_PV/_RC*/}/${PN}-${MY_PV}.tar.bz2"
fi
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc64 ~sparc ~x86"
IUSE="aac exscalibar flac gstreamer kde mysql noamazon opengl postgres
xmms visualization musicbrainz ipod ifp real"
# kde: enables compilation of the konqueror sidebar plugin

DEPEND="kde? ( || ( kde-base/konqueror kde-base/kdebase ) )
	>=media-libs/xine-lib-1_rc4
	gstreamer? ( =media-libs/gstreamer-0.10*
		=media-libs/gst-plugins-base-0.10* )
	musicbrainz? ( >=media-libs/tunepimp-0.3 )
	>=media-libs/taglib-1.4
	mysql? ( >=dev-db/mysql-4.0.16 )
	postgres? ( dev-db/postgresql )
	opengl? ( virtual/opengl )
	xmms? ( >=media-sound/xmms-1.2 )
	visualization? ( media-libs/libsdl
	                 >=media-plugins/libvisual-plugins-0.2 )
	ipod? ( media-libs/libgpod )
	aac? ( media-libs/libmp4v2 )
	exscalibar? ( media-libs/exscalibar )
	ifp? ( media-libs/libifp )
	real? ( media-video/realplayer )"

RDEPEND="${DEPEND}
	dev-lang/ruby"

DEPEND="${DEPEND}
	>=dev-util/pkgconfig-0.9.0"

need-kde 3.3

src_compile() {
	append-flags -fno-inline

	# Extra, unsupported engines are forcefully disabled.
	local myconf="$(use_with gstreamer gstreamer10)
	              $(use_enable mysql) $(use_enable postgres postgresql)
	              $(use_with opengl) $(use_with xmms)
	              $(use_with visualization libvisual)
	              $(use_enable !noamazon amazon)
	              $(use_with musicbrainz)
	              $(use_with exscalibar)
				  $(use_with ipod libgpod)
				  $(use_with aac mp4v2)
				  $(use_with ifp)
				  $(use_with real helix)
				  --with-xine
	              --without-mas
	              --without-nmm"

	kde_src_compile
}

