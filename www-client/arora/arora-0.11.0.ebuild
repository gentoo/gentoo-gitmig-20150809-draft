# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-client/arora/arora-0.11.0.ebuild,v 1.3 2011/11/20 12:21:48 pesa Exp $

EAPI=3

inherit eutils qt4-r2

DESCRIPTION="A cross-platform Qt4 WebKit browser"
HOMEPAGE="http://arora.googlecode.com/"
SRC_URI="http://arora.googlecode.com/files/${P}.tar.gz"

LICENSE="|| ( GPL-3 GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~arm ~ppc ~x86 ~x86-freebsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos ~x86-solaris"
IUSE="debug doc"

RDEPEND="x11-libs/qt-gui:4
	x11-libs/qt-sql:4
	x11-libs/qt-webkit:4
	x11-libs/qt-xmlpatterns:4"
DEPEND="${RDEPEND}
	doc? ( app-doc/doxygen )"

ARORA_LANGS="ast ca es es_CR et_EE fr_CA gl ms nb_NO nl pt_BR pt_PT sr@latin sr_CS uk
zh_CN zh_TW"
ARORA_NOLONGLANGS="cs_CZ da_DK de_DE el_GR fi_FI fr_FR he_IL hu_HU it_IT ja_JP
pl_PL ru_RU sk_SK tr_TR"

for L in ${ARORA_LANGS}; do
	IUSE+=" linguas_${L}"
done
for L in ${ARORA_NOLONGLANGS}; do
	IUSE+=" linguas_${L%_*}"
done

DOCS="AUTHORS ChangeLog README"

src_prepare() {
	# use Gentoo lingua designations
	mv src/locale/sr_RS@latin.ts src/locale/sr@latin.ts
	mv src/locale/sr_RS.ts src/locale/sr_CS.ts

	# process linguas
	local langs=
	for lingua in ${LINGUAS}; do
		if has ${lingua} ${ARORA_LANGS}; then
			langs+=" ${lingua}.ts"
		else
			for a in ${ARORA_NOLONGLANGS}; do
				if [[ ${lingua} == ${a%_*} ]]; then
					langs+=" ${a}.ts"
				fi
			done
		fi
	done

	# remove all translations, then add only the ones we want
	sed -i '/ts/d' src/locale/locale.pri || die
	sed -i "/^TRANSLATIONS/s:\\\:${langs}:" src/locale/locale.pri || die

	if ! use doc ; then
		sed -i 's|QMAKE_EXTRA|#QMAKE_EXTRA|' arora.pro || die
	fi
}

src_configure() {
	eqmake4 PREFIX="${EPREFIX}"/usr
}

src_compile() {
	qt4-r2_src_compile

	# don't pre-strip
	sed -i "/strip/d" src/Makefile || die
}
