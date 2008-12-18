# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/smplayer/smplayer-0.6.2-r1.ebuild,v 1.6 2008/12/18 07:44:50 yngwin Exp $

EAPI="1"
inherit eutils qt4

DESCRIPTION="Great Qt4 GUI front-end for mplayer"
HOMEPAGE="http://smplayer.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 hppa ~ppc ~ppc64 sparc x86 ~x86-fbsd"
IUSE=""
DEPEND="|| ( x11-libs/qt-gui:4
			>=x11-libs/qt-4.3:4 )"
RDEPEND="${DEPEND}
	>media-video/mplayer-1.0_rc1"

LANGS="bg ca cs de en_US es eu fi fr hu it ja ka ko mk nl pl pt_BR pt_PT sk sr sv tr zh_CN zh_TW"
NOLONGLANGS="el_GR ro_RO ru_RU sl_SI uk_UA"
for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done
for X in ${NOLONGLANGS}; do
	IUSE="${IUSE} linguas_${X%_*}"
done

pkg_setup() {
	if ! built_with_use --missing true media-video/mplayer ass \
		|| ! built_with_use --missing true media-video/mplayer srt; then
		echo
		ewarn "SMPlayer needs MPlayer to be built with USE=ass or srt for subtitle"
		ewarn "support. Please enable the ass or srt USE flag for mplayer and"
		ewarn "re-emerge media-video/mplayer before emerging smplayer."
		echo
		die "media-video/mplayer needs USE=ass or srt enabled"
	fi
	if ! built_with_use media-video/mplayer png; then
		echo
		ewarn "SMPlayer needs MPlayer built with USE=png for screenshot support."
		ewarn "Please enable the png USE flag for mplayer and re-emerge"
		ewarn "media-video/mplayer before emergeing smplayer."
		echo
		die "media-video/mplayer needs USE=png enabled"
	fi
}

src_compile() {
	local MY_SVNREV="1661"
	echo "SVN-r${MY_SVNREV}" > svn_revision.txt
	echo "#define SVN_REVISION \"SVN-r${MY_SVNREV}\"" > src/svn_revision.h

	# Fix paths in Makefile and allow parallel building
	sed -i -e "/^PREFIX=/s:/usr/local:/usr:" \
		-e "/^CONF_PREFIX=/s:\$(PREFIX)::" \
		-e "/^DOC_PATH=/s:packages/smplayer:${PF}:" \
		-e '/get_svn_revision.sh/,+2c\
	cd src && $(DEFS) $(MAKE)' \
		"${S}"/Makefile || die "sed failed"

	eqmake4 src/${PN}.pro -o src/Makefile
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
	for i in de es ja ro ; do
		rm -rf docs/$i
	done

	# remove windows-only files
	rm "${S}"/*.bat

	emake DESTDIR="${D}" install || die "emake install failed"
	prepalldocs
}
