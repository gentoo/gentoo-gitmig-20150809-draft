# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/smplayer/smplayer-0.6.8.ebuild,v 1.5 2009/11/23 14:34:49 maekke Exp $

EAPI="2"

inherit eutils qt4

MY_PV=${PV##*_p}
if [[ "${MY_PV}" != "${PV}" ]]; then
	# svn snapshot
	MY_PV=r${MY_PV}
	MY_P=${PN}-${MY_PV}
	S="${WORKDIR}/${MY_P}"
	SRC_URI="mirror://gentoo/${MY_P}.tar.bz2"
else
	# regular upstream release
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"
fi

DESCRIPTION="Great Qt4 GUI front-end for mplayer"
HOMEPAGE="http://smplayer.sourceforge.net"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~hppa ~ppc ~ppc64 ~sparc x86 ~x86-fbsd"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4"
RDEPEND="${DEPEND}
	media-video/mplayer[ass,png]"

LANGS="bg ca cs de en_US es et eu fi fr gl hu it ja ka ko ku mk nl pl pt_BR
pt sk sr sv tr zh_CN zh_TW"
# langs with long notation in pkg, but no long notation in portage:
NOLONGLANGS="ar_SY el_GR ro_RO ru_RU sl_SI uk_UA vi_VN"
for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
done
for X in ${NOLONGLANGS}; do
	IUSE="${IUSE} linguas_${X%_*}"
done

src_prepare() {
	# Force Ctrl+Q as default quit shortcut
	epatch "${FILESDIR}/${P}-quit.patch"

	# Upstream Makefile sucks
	sed -i -e "/^PREFIX=/s:/usr/local:/usr:" \
		-e "/^DOC_PATH=/s:packages/smplayer:${PF}:" \
		-e '/\.\/get_svn_revision\.sh/,+2c\
	cd src && $(DEFS) $(MAKE)' \
		"${S}"/Makefile || die "sed failed"

	# Turn debug message flooding off
	if ! use debug ; then
		sed -i 's:#\(DEFINES += NO_DEBUG_ON_CONSOLE\):\1:' \
			"${S}"/src/smplayer.pro || die "sed failed"
	fi
}

src_configure() {
	cd "${S}"/src
	echo "#define SVN_REVISION \"SVN-${MY_PV} (Gentoo)\"" > svn_revision.h
	eqmake4
}

gen_translation() {
	ebegin "Generating $1 translation"
	lrelease ${PN}_${1}.ts
	eend $? || die "failed to generate $1 translation"
}

src_compile() {
	emake || die "emake failed"

	# Generate translations
	cd "${S}"/src/translations
	local lang= nolangs= x=
	for lang in ${LINGUAS}; do
		if has ${lang} ${LANGS}; then
			gen_translation ${lang}
			continue
		elif [[ " ${NOLONGLANGS} " == *" ${lang}_"* ]]; then
			for x in ${NOLONGLANGS}; do
				if [[ "${lang}" == "${x%_*}" ]]; then
					gen_translation ${x}
					continue 2
				fi
			done
		fi
		nolangs="${nolangs} ${lang}"
	done
	[[ -n ${nolangs} ]] && ewarn "Sorry, but ${PN} does not support the LINGUAS:" ${nolangs}
	# install fails when no translation is present (bug 244370)
	[[ -z $(ls *.qm 2>/dev/null) ]] && gen_translation en_US
}

src_install() {
	# remove unneeded copies of GPL
	rm -f Copying.txt docs/{cs,en,ja,ru}/gpl.html
	rm -rf docs/{de,es,nl,ro}

	# remove windows-only files
	rm "${S}"/*.bat

	emake DESTDIR="${D}" install || die "emake install failed"
	prepalldocs
}
