# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/smplayer/smplayer-0.6.3.ebuild,v 1.1 2008/09/26 16:42:03 yngwin Exp $

EAPI=2
inherit eutils qt4

DESCRIPTION="Great Qt4 GUI front-end for mplayer"
HOMEPAGE="http://smplayer.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND="|| ( x11-libs/qt-gui:4
			>=x11-libs/qt-4.3:4 )"
RDEPEND="${DEPEND}
	>media-video/mplayer-1.0_rc1[png,srt]"

LANGS="bg ca cs de en_US es eu fi fr hu it ja ka ko ku mk nl pl pt_BR pt_PT sk sl sr sv tr zh_CN zh_TW"
NOLONGLANGS="ar_SY el_GR ro_RO ru_RU uk_UA"
for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done
for X in ${NOLONGLANGS}; do
	IUSE="${IUSE} linguas_${X%_*}"
done

src_prepare() {
	local MY_SVNREV="1882"
	echo "SVN-r${MY_SVNREV}" > svn_revision.txt
	echo "#define SVN_REVISION \"SVN-r${MY_SVNREV}\"" > src/svn_revision.h

	# Fix paths in Makefile and allow parallel building
	sed -i -e "/^PREFIX=/s:/usr/local:/usr:" \
		-e "/^CONF_PREFIX=/s:\$(PREFIX)::" \
		-e "/^DOC_PATH=/s:packages/smplayer:${PF}:" \
		-e '/get_svn_revision.sh/,+2c\
	cd src && $(DEFS) $(MAKE)' \
		"${S}"/Makefile || die "sed failed"
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
