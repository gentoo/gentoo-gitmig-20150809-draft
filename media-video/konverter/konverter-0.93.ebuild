# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/konverter/konverter-0.93.ebuild,v 1.2 2007/11/27 14:15:50 zzam Exp $

inherit qt3 eutils

IUSE=""

DESCRIPTION="A KDE MEncoder frontend for video-conversion."
HOMEPAGE="http://www.kraus.tk/projects/konverter/"
SRC_URI="http://www.kraus.tk/projects/${PN}/sources/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~ppc ~amd64"

S="${WORKDIR}/${PN}"

DEPEND="media-libs/xine-lib
	media-video/mplayer
	kde-base/kdelibs
	|| ( kde-base/kdebase-kioslaves
		kde-base/kdebase )"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"

	# make sure that sourced binary will not be install
	rm "${S}"/src/bin/${PN}

	epatch "${FILESDIR}"/${P}-pro_files.patch
	epatch "${FILESDIR}"/${PN}-desktop.patch

	# icon for desktop file
	cp "${S}"/media/hi32-app-konverter.png "${S}"/media/${PN}.png
}

src_compile() {
	qmake ${PN}.pro \
		QTDIR=/usr/lib \
		QMAKE_CFLAGS_RELEASE="${CFLAGS}" \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE=/usr/bin/qmake \
		QMAKE_RPATH= \
		|| die "qmake failed"

	cd "${S}"/src
	qmake src.pro \
		QTDIR=/usr/lib \
		QMAKE_CFLAGS_RELEASE="${CFLAGS}" \
		QMAKE_CXXFLAGS_RELEASE="${CXXFLAGS}" \
		QMAKE=/usr/bin/qmake \
		QMAKE_RPATH= \
		|| die "qmake failed"

	emake || die "make failed"
}

src_install() {
	# for now - useless...
	# make INSTALL_ROOT="${D}" install || die "make install failed"

	dobin "${S}"/bin/${PN}
	dodoc "${S}"/distfiles/{AUTHORS,ChangeLog,README,TODO}

	domenu "${S}"/distfiles/${PN}.desktop
	doicon "${S}"/media/${PN}.png
}
