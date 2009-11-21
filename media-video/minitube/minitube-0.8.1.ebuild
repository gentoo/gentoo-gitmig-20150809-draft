# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/minitube/minitube-0.8.1.ebuild,v 1.1 2009/11/21 05:16:49 hwoarang Exp $

EAPI="2"

inherit qt4

DESCRIPTION="Qt4 YouTube Client"
HOMEPAGE="http://flavio.tordini.org/minitube"
SRC_URI="http://flavio.tordini.org/files/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kde"
LNGS="cs de es es_AR fr he hr hu it ja pl pt_BR ru tr uk"
for lng in ${LNGS}; do
	IUSE="${IUSE} linguas_${lng}"
done

DEPEND="x11-libs/qt-gui:4[accessibility]
	kde? ( media-sound/phonon[gstreamer] )
	!kde? ( x11-libs/qt-phonon:4 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

LANGS="es_AR pt_BR uk"
LANGSNOLONG="cs_CZ de_DE es_ES he_IL hr_HR hu_HU fr_FR it_IT jp_JP pl_PL ru_RU
tr_TR"

src_configure() {
	eqmake4 ${PN}.pro
}

src_install() {
	dobin build/target/minitube || die "dobin failed"
	newicon images/app.png minitube.png || die "doicon failed"
	make_desktop_entry minitube MiniTube minitube.png "Qt;AudioVideo;Video" \
		|| die "make_desktop_entry failed"
	#translations
	insinto "/usr/share/${PN}/locale/"
	for lang in ${LINGUAS}; do
		for x in ${LANGS}; do
			if [[ ${x} == ${lang} ]]; then
				doins "build/target/locale/${x}.qm" || die "doins failed"
			fi
		done
		for x in ${LANGSNOLONG}; do
			if [[ ${x%_*} == ${lang} ]]; then
				doins "build/target/locale/${x}.qm" || die "doins failed"
			fi
		done
	done
}
