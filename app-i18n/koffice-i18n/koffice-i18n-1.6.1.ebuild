# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/koffice-i18n/koffice-i18n-1.6.1.ebuild,v 1.8 2007/03/31 00:32:25 carlo Exp $

inherit kde

RV="${PV}"

DESCRIPTION="KOffice internationalization package."
HOMEPAGE="http://www.koffice.org/"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="amd64 ~hppa ppc ppc64 sparc x86"
IUSE=""

RDEPEND="|| ( >=app-office/koffice-libs-${PV} >=app-office/koffice-${PV} )
	kde-base/kde-i18n"
need-kde 3.5

LANGS="ca cs cy da de el en_GB es et eu fi fr hu it ja lv ms nb nl pl pt pt_BR ru sk sl sr sr@Latn sv uk zh_CN zh_TW"

for X in ${LANGS}; do
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://kde/stable/koffice-${PV/_/-}/src/koffice-l10n/koffice-l10n-${X}-${RV/_/-}.tar.bz2 )"
	IUSE="${IUSE} linguas_${X}"
done


src_unpack() {
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

	unpack ${A}
}

src_compile() {
	local _S=${S}
	for dir in `ls ${WORKDIR}`; do
		S=${WORKDIR}/${dir}
		if [[ "${dir}" == "koffice-l10n-es-1.6.1" ]] ; then
			cd ${S}
			epatch ${FILESDIR}/koffice-18n-1.6.1-es-fix.diff || die
		fi
		kde_src_compile
	done
	S=${_S}
}

src_install() {
	local _S=${S}
	for dir in `ls ${WORKDIR}`; do
		cd ${WORKDIR}/${dir}
		make DESTDIR=${D} install
	done
	S=${_S}
}
