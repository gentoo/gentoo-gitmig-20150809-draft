# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/minitube/minitube-1.8.ebuild,v 1.2 2012/07/02 18:48:57 hwoarang Exp $

EAPI=4
LANGS="ar ca da el en es es_AR es_ES fi fr gl hr hu ia id it nb nl nn pl pt pt_BR ro ru sk sl sq sr sv_SE te tr zh_CN"
LANGSLONG="ca_ES de_DE fi_FI he_IL id_ID ka_GE pl_PL uk_UA"

inherit qt4-r2

DESCRIPTION="Qt4 YouTube Client"
HOMEPAGE="http://flavio.tordini.org/minitube"
SRC_URI="http://flavio.tordini.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug gstreamer kde"

DEPEND=">=x11-libs/qt-gui-4.6:4[accessibility]
	>=x11-libs/qt-dbus-4.6:4
	kde? ( || ( media-libs/phonon[gstreamer?] >=x11-libs/qt-phonon-4.6:4 ) )
	!kde? ( || ( >=x11-libs/qt-phonon-4.6:4 media-libs/phonon[gstreamer?] ) )
	gstreamer? (
		media-plugins/gst-plugins-soup
		media-plugins/gst-plugins-ffmpeg
		media-plugins/gst-plugins-faac
		media-plugins/gst-plugins-faad
	)
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

DOCS="AUTHORS CHANGES TODO"

src_prepare() {
	qt4-r2_src_prepare

	# Remove unneeded translations
	local lang= trans=
	for lang in ${LANGS}; do
		use linguas_${lang} && trans+=" ${lang}.ts"
	done
	for lang in ${LANGSLONG}; do
		use linguas_${lang%_*} && trans+=" ${lang}.ts"
	done
	if [[ -n ${trans} ]]; then
		sed -i -e "/^TRANSLATIONS/s/+=.*/+=${trans}/" locale/locale.pri || die
	fi
	# gcc-4.7. Bug #422977
	epatch "${FILESDIR}"/${P}-gcc4.7.patch
}

src_install() {
	qt4-r2_src_install
	newicon images/app.png minitube.png
}
