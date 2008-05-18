# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/smplayer/smplayer-0.6.0_rc4.ebuild,v 1.7 2008/05/18 23:09:20 jer Exp $

EAPI="1"
inherit eutils qt4

MY_P=${P/_rc/rc}
DESCRIPTION="Great front-end for mplayer written in Qt4"
HOMEPAGE="http://smplayer.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""
DEPEND="|| ( ( x11-libs/qt-gui:4
				x11-libs/qt-qt3support:4 )
			>=x11-libs/qt-4.3:4 )"
RDEPEND="${DEPEND}
	>media-video/mplayer-1.0_rc1"

LANGS="bg cs de en_US es eu fi fr hu it ja ka ko mk nl pl pt_BR pt_PT sk sr sv tr zh_CN zh_TW"
NOLONGLANGS="el_GR ro_RO ru_RU uk_UA"
for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done
for X in ${NOLONGLANGS}; do
	IUSE="${IUSE} linguas_${X%_*}"
done

S=${WORKDIR}/${MY_P}

pkg_setup() {
	if has_version ">=x11-libs/qt-4.3:4"; then
		QT4_BUILT_WITH_USE_CHECK="qt3support"
	else
		if ! built_with_use "x11-libs/qt-gui:4" qt3support; then
			eerror "You have to built x11-libs/qt-gui:4 with qt3support."
			die "qt3support in qt-gui disabled"
		fi
	fi
	qt4_pkg_setup
}

src_compile() {
	local MY_SVNREV="UNKNOWN"
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

	emake DESTDIR="${D}" install || die "emake install failed"
	prepalldocs
}

pkg_postinst() {
	if ! built_with_use media-video/mplayer png; then
		echo
		ewarn "SMPlayer needs the media-video/mplayer package built with USE=png."
		ewarn "To prevent crashes, please rebuild mplayer with png support, or"
		ewarn "alternatively, clear the Folder for storing screenshots field in"
		ewarn "the Preferences dialog."
		echo
	fi
}
