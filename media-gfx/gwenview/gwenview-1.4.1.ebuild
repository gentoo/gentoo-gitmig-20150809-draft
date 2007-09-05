# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/gwenview/gwenview-1.4.1.ebuild,v 1.6 2007/09/05 16:59:47 armin76 Exp $

inherit kde

MY_P=${P/_/}
S=${WORKDIR}/${MY_P}

DESCRIPTION="image viewer for KDE"
HOMEPAGE="http://gwenview.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~ppc ~sparc x86 ~x86-fbsd"
IUSE="kipi kdeenablefinal"

DEPEND="kipi? ( >=media-plugins/kipi-plugins-0.1.0_beta2 )
	media-gfx/exiv2"

need-kde 3

I18N="${PN}-i18n-${PV}"

LANGS="ar az bg br ca cs cy da de el en_GB es et fi fo fr ga gl he hi hu
is it ja ka ko lt nb nl nso pa pl pt pt_BR ro ru rw sk sr sr@Latn sv ta
th tr uk xh zh_CN zh_TW zu"

for X in ${LANGS}; do
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://sourceforge/${PN}/${I18N}.tar.bz2 )"
	IUSE="${IUSE} linguas_${X}"
done

pkg_setup(){
	if use kipi ; then
		slot_rebuild "media-plugins/kipi-plugins" && die
	fi
}

src_unpack() {
	kde_src_unpack

	if [ -d "${WORKDIR}/${I18N}" ]; then
		cd "${WORKDIR}/${I18N}"
		for X in ${LANGS}; do
			use linguas_${X} || rm -rf "${X}"
		done
		rm -f configure
	fi
}

src_compile() {
	local myconf="$(use_enable kipi)"
	rm -f "${S}/configure"

	kde_src_compile

	if [ -d "${WORKDIR}/${I18N}" ]; then
		KDE_S="${WORKDIR}/${I18N}" \
		kde_src_compile
	fi
}

src_install() {
	kde_src_install

	if [ -d "${WORKDIR}/${I18N}" ]; then
		KDE_S="${WORKDIR}/${I18N}" \
		kde_src_install
	fi
}
