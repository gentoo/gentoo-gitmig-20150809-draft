# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/2mandvd/2mandvd-1.4.ebuild,v 1.1 2010/10/05 22:15:07 chiiph Exp $

EAPI="2"
LANGS="de en he it pl pt ru"

inherit qt4-r2

MY_PN="2ManDVD"

DESCRIPTION="The successor of ManDVD"
HOMEPAGE="http://kde-apps.org/content/show.php?content=99450"
SRC_URI="http://download.tuxfamily.org/${PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-lang/perl
	media-video/dvdauthor
	media-video/ffmpegthumbnailer
	media-fonts/dejavu
	media-sound/sox
	media-video/mplayer
	media-libs/netpbm
	media-video/mjpegtools
	|| ( app-cdr/cdrkit app-cdr/cdrtools )
	media-libs/xine-lib
	x11-libs/qt-gui:4
	x11-libs/qt-webkit:4"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${PN}-fix-const-char-concatenation.patch"
)

S="${WORKDIR}/${MY_PN}"

src_prepare() {
	# fix installation path
	for file in mainfrm.cpp media_browser.cpp rendering.cpp; do
		sed -i "s:qApp->applicationDirPath().\?+.\?\":\"/usr/share/${PN}/:" \
			${file} || die "sed failed"
	done

	sed -i "s:qApp->applicationDirPath():\"/usr/share/${PN}/\":" \
		mainfrm.cpp || die "sed failed"

	qt4-r2_src_prepare
}

src_configure() {
	eqmake4 ${MY_PN}.pro
}

src_install() {
	newbin 2ManDVD ${PN} || die "newbin failed"
	dodoc README.txt || die "dodoc failed"
	insinto /usr/share/${PN}/
	doins -r Bibliotheque || die "failed to install Bibliotheque"
	doins -r Interface || die "failed to install Interface"
	#bug 305625
	doins fake.pl || die "failed to install fake.pl"
	doicon Interface/mandvdico.png || die "doicon failed"
	# Desktop icon
	make_desktop_entry ${PN} 2ManDVD mandvdico "Qt;AudioVideo;Video" \
		|| die "make_desktop_entry failed"
	insinto /usr/share/${PN}
	for lang in ${LINGUAS}; do
		for x in ${LANGS}; do
			[[ ${lang} == ${x} ]] && doins ${PN}_${x}.qm
		done
	done
	[[ -z ${LINGUAS} ]] && doins ${PN}_en.qm
}
