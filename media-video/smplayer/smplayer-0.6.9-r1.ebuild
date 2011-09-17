# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/smplayer/smplayer-0.6.9-r1.ebuild,v 1.1 2011/09/17 00:10:13 beandog Exp $

EAPI="2"
LANGS="bg ca cs de en_US es et eu fi fr gl hu it ja ka ko ku mk nl pl pt_BR
pt sk sr sv tr zh_CN zh_TW"
LANGSLONG="ar_SY el_GR ro_RO ru_RU sl_SI uk_UA vi_VN"

inherit eutils qt4-r2

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
HOMEPAGE="http://smplayer.berlios.de/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug"

DEPEND="x11-libs/qt-gui:4"
MPLAYER_USE="[ass,png]"
RDEPEND="${DEPEND}
	|| ( media-video/mplayer${MPLAYER_USE} media-video/mplayer2[libass,png] media-video/mplayer2${MPLAYER_USE} )"

src_prepare() {
	# Force Ctrl+Q as default quit shortcut
	epatch "${FILESDIR}/${PN}-0.6.8-quit.patch"

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
	emake || die

	# Generate translations
	cd "${S}"/src/translations
	local lang= nolangs= x=
	for lang in ${LINGUAS}; do
		if has ${lang} ${LANGS}; then
			gen_translation ${lang}
			continue
		elif [[ " ${LANGSLONG} " == *" ${lang}_"* ]]; then
			for x in ${LANGSLONG}; do
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

	emake DESTDIR="${D}" install || die
	prepalldocs
}
