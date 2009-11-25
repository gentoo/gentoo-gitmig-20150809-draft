# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/2mandvd/2mandvd-1.2.ebuild,v 1.1 2009/11/25 21:12:37 hwoarang Exp $

EAPI="2"

inherit qt4

MY_PN="2ManDVD"

DESCRIPTION="The successor of ManDVD"
HOMEPAGE="http://kde-apps.org/content/show.php?content=99450"
SRC_URI="http://download.tuxfamily.org/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="media-video/dvdauthor
	media-video/ffmpegthumbnailer
	media-fonts/dejavu
	media-sound/sox
	media-video/mplayer
	media-libs/netpbm
	media-video/mjpegtools
	|| ( app-cdr/cdrkit app-cdr/cdrtools )
	media-libs/xine-lib
	x11-libs/qt-gui:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_PN}"

LANGS="de en he it pl pt ru"

for x in ${LANGS}; do
	IUSE="${IUSE} linguas_${x}"
done

src_prepare() {
	# fix installation path
	for file in mainfrm.cpp media_browser.cpp rendering.cpp; do
		sed -i "s:qApp->applicationDirPath().\?+.\?\":\"/usr/share/${PN}/:" \
			${file} || die "sed failed"
	done

	sed -i "s:qApp->applicationDirPath():\"/usr/share/${PN}/\":" \
		mainfrm.cpp || die "sed failed"

	qt4_src_prepare
}

src_configure() {
	eqmake4 ${MY_PN}.pro
}

src_install() {
	dobin 2ManDVD || die "dobin failed"
	dodoc README.txt || die "dodoc failed"
	insinto /usr/share/${PN}/
	doins -r Bibliotheque || die "failed to install Bibliotheque"
	doins -r Interface || die "failed to install Interface"
	doicon Interface/mandvdico.png || die "doicon failed"
	# Desktop icon
	make_desktop_entry 2ManDVD 2ManDVD mandvdico "Qt;AudioVideo;Video" \
		|| die "make_desktop_entry failed"
	insinto /usr/share/${PN}
	for lang in ${LINGUAS}; do
		for x in ${LANGS}; do
			[[ ${lang} == ${x} ]] && doins ${PN}_${x}.qm
		done
	done
}
