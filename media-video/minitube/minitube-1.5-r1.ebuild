# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/minitube/minitube-1.5-r1.ebuild,v 1.1 2011/08/07 13:46:37 hwoarang Exp $

EAPI="4"
LANGS="ar es pt_BR pt_PT uk"
LANGSLONG="bg_BG cs_CZ de_DE el_GR es he_IL hr_HR hu_HU fr_FR fi_FI it_IT
ja_JP nl_NL nb_NO pl_PL ro_RO ru_RU tr_TR"

inherit qt4-r2

DESCRIPTION="Qt4 YouTube Client"
HOMEPAGE="http://flavio.tordini.org/minitube"
SRC_URI="http://flavio.tordini.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug kde gstreamer"

DEPEND="x11-libs/qt-gui:4[accessibility]
	x11-libs/qt-dbus:4
	kde? ( || ( media-libs/phonon[gstreamer?]  x11-libs/qt-phonon:4 ) )
	!kde? ( || ( x11-libs/qt-phonon media-libs/phonon[gstreamer?] ) )
	gstreamer? (
		media-plugins/gst-plugins-soup
		media-plugins/gst-plugins-ffmpeg
		media-plugins/gst-plugins-faac
		media-plugins/gst-plugins-faad
	)
"

RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

PATCHES=(
	"${FILESDIR}"/${P}-use-correct-env-variable.patch
)

src_install() {
	emake INSTALL_ROOT="${D}" install
	newicon images/app.png minitube.png
	#translations
	insinto "/usr/share/${PN}/locale/"
	for lang in ${LINGUAS}; do
		for x in ${LANGS}; do
			if [[ ${x} == ${lang} ]]; then
				doins "build/target/locale/${x}.qm"
			fi
		done
		for x in ${LANGSLONG}; do
			if [[ ${x%_*} == ${lang} ]]; then
				doins "build/target/locale/${x}.qm"
			fi
		done
	done
}
