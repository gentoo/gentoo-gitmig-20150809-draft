# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/minitube/minitube-0.3.ebuild,v 1.1 2009/06/16 10:20:19 hwoarang Exp $

EAPI="2"

inherit qt4

MY_PN="${PN}-src"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Qt4 YouTube Client"
HOMEPAGE="http://flavio.tordini.org/minitube"
SRC_URI="http://flavio.tordini.org/files/${PN}/${MY_P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug kde linguas_it linguas_pt_BR linguas_ru"

DEPEND="x11-libs/qt-gui:4[accessibility]
	kde? ( media-sound/phonon[gstreamer] )
	!kde? ( x11-libs/qt-phonon:4 )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}"

LANGS="pt_BR"
LANGSNOLONG="it_IT ru_RU"

src_prepare() {
	use kde && epatch "${FILESDIR}"/fix_headers_translations-${PV}.patch
	qt4_src_prepare
}
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
