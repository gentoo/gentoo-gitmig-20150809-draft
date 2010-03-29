# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/minitube/minitube-0.9.ebuild,v 1.3 2010/03/29 15:58:25 hwoarang Exp $

EAPI="2"
LANGS="es_AR pt_BR uk"
LANGSLONG="cs_CZ de_DE es_ES he_IL hr_HR hu_HU fr_FR it_IT ja_JP nb_NO pl_PL ru_RU
tr_TR"

inherit qt4-r2

DESCRIPTION="Qt4 YouTube Client"
HOMEPAGE="http://flavio.tordini.org/minitube"
SRC_URI="http://flavio.tordini.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kde"

DEPEND="x11-libs/qt-gui:4[accessibility]
	kde? ( media-sound/phonon )
	!kde? ( x11-libs/qt-phonon:4 )
	media-plugins/gst-plugins-soup
	media-plugins/gst-plugins-ffmpeg
	media-plugins/gst-plugins-faac
	media-plugins/gst-plugins-faad"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

src_install() {
	dobin build/target/minitube || die "dobin failed"
	newicon images/app.png minitube.png || die "doicon failed"
	make_desktop_entry minitube MiniTube minitube "Qt;AudioVideo;Video" \
		|| die "make_desktop_entry failed"
	#translations
	insinto "/usr/share/${PN}/locale/"
	for lang in ${LINGUAS}; do
		for x in ${LANGS}; do
			if [[ ${x} == ${lang} ]]; then
				doins "build/target/locale/${x}.qm" || die "doins failed"
			fi
		done
		for x in ${LANGSLONG}; do
			if [[ ${x%_*} == ${lang} ]]; then
				doins "build/target/locale/${x}.qm" || die "doins failed"
			fi
		done
	done
}
