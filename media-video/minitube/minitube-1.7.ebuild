# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/minitube/minitube-1.7.ebuild,v 1.1 2012/01/06 19:18:54 hwoarang Exp $

EAPI="4"
LANGS="ca da es es_AR es_ES el fr gl hr hu ia id it nb nl pl pt pt_BR ro
ru sl sq sr sv_SE te tr zh_CN"
LANGSLONG="ca_ES de_DE fi_FI he_IL id_ID ka_GE pl_PL uk_UA"

inherit qt4-r2

DESCRIPTION="Qt4 YouTube Client"
HOMEPAGE="http://flavio.tordini.org/minitube"
SRC_URI="http://flavio.tordini.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
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

src_install() {
	emake INSTALL_ROOT="${D}" install
	newicon images/app.png minitube.png
	#translations
	insinto "/usr/share/${PN}/locale/"
	for x in ${LANGS}; do
		if ! has ${x} ${LINGUAS}; then
				rm "${D}"/usr/share/${PN}/locale/${x}.qm || die
		fi
	done
	for x in ${LANGSLONG}; do
		if ! has ${x%_*} ${LINGUAS}; then
			rm "${D}"/usr/share/${PN}/locale/${x}.qm || die
		fi
	done
}
