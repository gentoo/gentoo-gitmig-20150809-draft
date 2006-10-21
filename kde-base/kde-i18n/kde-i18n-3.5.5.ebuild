# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/kde-base/kde-i18n/kde-i18n-3.5.5.ebuild,v 1.2 2006/10/21 15:35:20 flameeyes Exp $

inherit kde

DESCRIPTION="KDE internationalization package"
HOMEPAGE="http://www.kde.org/"
LICENSE="GPL-2"

SLOT="${KDEMAJORVER}.${KDEMINORVER}"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

need-kde ${PV}
LANGS="af ar az bg bn br bs ca cs cy da de el en_GB eo es et
eu fa fi fr fy ga gl he hi hr hu is it ja kk km ko lt lv
mk mn ms nb nds nl nn pa pl pt pt_BR ro ru rw se sk sl
sr sr@Latn ss sv ta tg tr uk uz vi zh_CN zh_TW"

for X in ${LANGS} ; do
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://kde/stable/${PV}/src/kde-i18n/kde-i18n-${X}-${PV}.tar.bz2 )"
	IUSE="${IUSE} linguas_${X}"
done

pkg_setup() {
	if [ -z "${A}" ]; then
		echo
		eerror "You must set the LINGUAS environment variable to a list of valid"
		eerror "language codes, one for each language you would like to install."
		eerror "e.g.: LINGUAS=\"sv de pt\""
		eerror ""
		eerror "The available language codes are:"
		echo "${LANGS}"
		echo
		die
	fi
}

src_unpack() {
	# Override kde_src_unpack.
	unpack ${A}

	# Work around KDE bug 126311.
	for dir in `ls "${WORKDIR}"`; do
		lang=`echo ${dir} | cut -f3 -d-`

		[[ -e "${WORKDIR}/${dir}/docs/common/Makefile.in" ]] || continue
		sed -e "s:\$(KDE_LANG)/${lang}/:\$(KDE_LANG)/:g" \
			-i "${WORKDIR}/${dir}/docs/common/Makefile.in" || die "Failed to fix ${lang}."
	done
}

src_compile() {
	for dir in `ls "${WORKDIR}"`; do
		KDE_S="${WORKDIR}/${dir}"
		kde_src_compile myconf
		myconf="${myconf} --prefix=${KDEDIR}"
		kde_src_compile configure
		kde_src_compile make
	done
}

src_install() {
	for dir in `ls "${WORKDIR}"`; do
		cd "${WORKDIR}/${dir}"
		emake DESTDIR="${D}" install || die
	done
}
