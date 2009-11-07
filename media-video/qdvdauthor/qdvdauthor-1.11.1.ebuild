# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/qdvdauthor/qdvdauthor-1.11.1.ebuild,v 1.2 2009/11/07 17:23:20 volkmar Exp $

EAPI=2

inherit eutils flag-o-matic qt4 qt3

DESCRIPTION="'Q' DVD-Author is a GUI frontend for dvdauthor written in Qt"
HOMEPAGE="http://qdvdauthor.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
		templates? ( mirror://sourceforge/${PN}/${PN}-templates-1.10.0.tar.bz2
					http://${PN}.sourceforge.net/data/masks.tar.bz2 )"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="mplayer +xine plugins cdr templates debug"

DEPEND="media-video/dvdauthor
	media-gfx/jhead
	media-video/ffmpeg
	media-video/mjpegtools
	xine? ( media-libs/xine-lib )
	mplayer? ( media-video/mplayer )
	!xine? ( !mplayer? ( media-libs/xine-lib ) )
	x11-libs/qt:3
	x11-libs/qt-gui:4
	x11-libs/libX11
	templates? ( app-text/convmv )"

RDEPEND="${DEPEND}
	app-cdr/dvdisaster
	media-libs/netpbm
	media-video/dv2sub
	media-video/videotrans
	media-gfx/imagemagick
	media-sound/toolame
	media-sound/lame
	media-sound/sox
	media-sound/vorbis-tools
	cdr? ( || ( virtual/cdrtools app-cdr/dvd+rw-tools ) )"

TEMPLATES="${WORKDIR}"/${PN}-templates-1.10.0

pkg_setup() {
	if ! use xine && ! use mplayer ; then
		eerror "You have to enable at least one of the use flags xine or \
			mplayer"
		die "xine and mplayer flag unset."
	fi
}

src_prepare() {
	sed -i -e 's:backround:background:g' qdvdauthor/qdvdauthor.pro \
		|| die "sed failed"

	mv "${WORKDIR}"/masks ${TEMPLATES}

	# remove spaces in filenames
	local OIFS IFS i
	OIFS=${IFS}; IFS=$'\n'
	for i in $(find ${TEMPLATES} -depth -name '* *') ; do
		mv ${i} $(dirname ${i})/$(basename ${i// /-})
	done
	IFS=${OIFS}

	# fix filename encoding
	convmv --notest -r -f iso-8859-15 -t utf8 ${TEMPLATES}/buttons 1>>/dev/null 2>&1
}

src_configure() {
	if use xine ; then
		export WITH_XINE_SUPPORT=1
	fi

	if use mplayer ; then
		export WITH_MPLAYER_SUPPORT=1
	fi

	export WITH_VLC_SUPPORT=0

	eqmake3 all.pro

	cd "${S}"/qdvdauthor
	eqmake3 qdvdauthor.pro

	cd "${S}"/qdvdauthor/qplayer
	eqmake3 qplayer.pro

	if use plugins ; then
		for i in simpledvd complexdvd menuslide testplugs; do
			cd "${S}"/qdvdauthor/plugins/${i}
			eqmake3 ${i}.pro
		done
	fi

	cd "${S}"/addons/jhead/libjhead
	eqmake3 interface.pro

	cd "${S}"/qrender
	eqmake4 qrender.pro
}

src_compile() {
	cd "${S}"/qdvdauthor
	emake || die "emake failed"

	cd "${S}"/qdvdauthor/qplayer
	emake || die "emake failed"

	if use plugins ; then
		for i in simpledvd complexdvd menuslide testplugs; do
			cd "${S}"/qdvdauthor/plugins/${i}
			emake || die "emake failed"
			eqmake3 ${i}.pro
		done
	fi

	cd "${S}"/addons/jhead/libjhead
	emake || die "emake failed"
	eqmake3 interface.pro -o Makefile.interface

	cd "${S}"/qrender
	emake || die "emake failed"
}

src_install() {
	cd "${S}"/qdvdauthor
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	cd "${S}"/qdvdauthor/qplayer
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	if use plugins ; then
		for i in simpledvd complexdvd; do
			cd "${S}"/qdvdauthor/plugins/${i}
			emake INSTALL_ROOT="${D}" install || die "emake install failed"
		done
	fi

	cd "${S}"/addons/jhead/libjhead
	emake INSTALL_ROOT="${D}" -f Makefile.interface install || \
		die "emake install failed"

	cd "${S}"/qrender
	emake INSTALL_ROOT="${D}" install || die "emake install failed"

	cd "${TEMPLATES}"
	if use templates ; then
		insinto /usr/share/qdvdauthor
		doins -r animated buttons masks slideshow static
	fi

	cd "${S}"
	dodoc CHANGELOG README
	domenu qdvdauthor.desktop
	doicon qdvdauthor.png
}
