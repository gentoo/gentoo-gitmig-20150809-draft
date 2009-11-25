# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/smile/smile-0.9.10.ebuild,v 1.3 2009/11/25 22:23:30 maekke Exp $

EAPI="2"

inherit qt4

DESCRIPTION="Slideshow Maker In Linux Environement"
HOMEPAGE="http://smile.tuxfamily.org/"
SRC_URI="http://download.tuxfamily.org/smiletool/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 x86"
IUSE="debug"

DEPEND="media-sound/sox
	media-video/mplayer
	x11-libs/qt-gui:4[debug?]
	x11-libs/qt-opengl:4[debug?]
	x11-libs/qt-webkit:4[debug?]
	media-gfx/imagemagick"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/fix_installation.patch"
	"${FILESDIR}/fix_docs-${PV}.patch"
)
LANGS="de en it pl pt ru"

for x in ${LANGS};do
	IUSE="${IUSE} linguas_${x}"
done

S="${WORKDIR}/${PN}"

src_configure() {
	eqmake4 ${PN}.pro
}

src_install() {
	dobin smile || die "dobin failed"
	doicon Interface/Theme/${PN}.png || die "doicon failed"
	make_desktop_entry smile Smile smile "Qt;AudioVideo;Video"

	dodoc BIB_ManSlide/Help/doc_en.html
	dodoc BIB_ManSlide/Help/doc_fr.html
	insinto /usr/share/doc/${PF}/
	doins -r BIB_ManSlide/Help/images
	doins -r BIB_ManSlide/Help/images_en
	doins -r BIB_ManSlide/Help/images_fr
	#translations
	insinto /usr/share/${PN}/translations/
	for lang in ${LINGUAS};do
		for x in ${LANGS};do
			if [[ ${lang} == ${x} ]];then
				doins ${PN}_${x}.qm || die "failed to install ${x} translation"
			fi
		done
	done
}
