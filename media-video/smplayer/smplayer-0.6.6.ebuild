# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/smplayer/smplayer-0.6.6.ebuild,v 1.4 2009/02/09 18:51:06 armin76 Exp $

EAPI=2
inherit eutils qt4

DESCRIPTION="Great Qt4 GUI front-end for mplayer"
HOMEPAGE="http://smplayer.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 ~hppa ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE="debug"
DEPEND="|| ( x11-libs/qt-gui:4
			=x11-libs/qt-4.3* )"
RDEPEND="${DEPEND}
	media-video/mplayer[ass,png]"

LANGS="bg ca cs de en_US es eu fi fr gl hu it ja ka ko ku mk nl pl pt_BR pt_PT sk sr sv tr zh_CN zh_TW"
NOLONGLANGS="ar_SY el_GR ro_RO ru_RU sl_SI uk_UA"
for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done
for X in ${NOLONGLANGS}; do
	IUSE="${IUSE} linguas_${X%_*}"
done

src_prepare() {
	# Fix paths in Makefile and allow parallel building
	sed -i -e "/^PREFIX=/s:/usr/local:/usr:" \
		-e "/^CONF_PREFIX=/s:\$(PREFIX)::" \
		-e "/^DOC_PATH=/s:packages/smplayer:${PF}:" \
		-e '/get_svn_revision.sh/,+2c\
	cd src && $(DEFS) $(MAKE)' \
		"${S}"/Makefile || die "sed failed"

	# Turn debug message flooding off
	if ! use debug ; then
		sed -i "s:#DEFINES += NO_DEBUG_ON_CONSOLE:DEFINES += NO_DEBUG_ON_CONSOLE:" \
		"${S}"/src/smplayer.pro || die "sed failed"
	fi
}

src_configure() {
	eqmake4 src/${PN}.pro -o src/Makefile
}

src_compile() {
	emake || die "emake failed"

	# Generate translations
	cd "${S}"/src/translations
	local LANG=
	for LANG in ${LINGUAS}; do
		if has ${LANG} ${LANGS}; then
			einfo "Generating ${LANG} translation ..."
			lrelease ${PN}_${LANG}.ts || die "Failed to generate ${LANG} translation!"
			continue
		elif [[ " ${NOLONGLANGS} " == *" ${LANG}_"* ]]; then
			local X=
			for X in ${NOLONGLANGS}; do
				if [[ "${LANG}" == "${X%_*}" ]]; then
					einfo "Generating ${X} translation ..."
					lrelease ${PN}_${X}.ts || die "Failed to generate ${X} translation!"
					continue 2
				fi
			done
		fi
		ewarn "Sorry, but ${PN} does not support the ${LANG} LINGUA."
	done
	# install fails when no translation is present (bug 244370)
	[[ -f *.qm ]] || lrelease ${PN}_en_US.ts
}

src_install() {
	# remove unneeded copies of GPL
	rm Copying.txt docs/en/gpl.html docs/ru/gpl.html
	for i in de es ja nl ro ; do
		rm -rf docs/$i
	done

	# remove windows-only files
	rm "${S}"/*.bat

	emake DESTDIR="${D}" install || die "emake install failed"
	prepalldocs
}
