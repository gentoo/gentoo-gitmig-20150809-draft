# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-text/bibletime/bibletime-1.6.5.ebuild,v 1.1 2008/01/05 18:03:47 beandog Exp $

inherit kde eutils versionator

DESCRIPTION="KDE Bible study application using the SWORD library."
HOMEPAGE="http://www.bibletime.info/"
SRC_URI="mirror://sourceforge/bibletime/${P}.tar.bz2"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND="=app-text/sword-1.5.10*
	>=dev-cpp/clucene-0.9.16"

LANGS_PKG=${PN}-i18n-${PV}
LANGS="af bg cs da de en_GB es fi fr hu it ko nl nn_NO no pl pt_BR ro ru sk uk"
LANGS_DOC="bg cs de fi fr it ko nl pt_BR ru"

for X in ${LANGS}; do
	IUSE="${IUSE} linguas_${X}"
	SRC_URI="${SRC_URI} linguas_${X}? ( mirror://sourceforge/bibletime/${LANGS_PKG}.tar.bz2 )"
done

need-kde 3.4

pkg_setup() {
	if ! built_with_use app-text/sword curl; then
		echo
		ewarn "The SWORD library may not have been compiled with curl support."
		ewarn "If you wish to use BibleTime's ability to download modules"
		ewarn "straight from the SWORD website, please make sure app-text/sword"
		ewarn "was compiled with USE=\"curl\"."
		ewarn "Press ctrl+c to abort the merge of BibleTime if you want to"
		ewarn "recompile SWORD with curl support."
		echo
		ebeep 5
	fi
}

src_compile() {
	cd ${S}

	# Those paths are missing a slash.
	sed -i -e "s:\$(kde_htmldir):\$(kde_htmldir)/:g" ${KDE_S}/docs/handbook/unicode/Makefile.*
	sed -i -e "s:\$(kde_htmldir):\$(kde_htmldir)/:g" ${KDE_S}/docs/handbook/html/Makefile.*
	sed -i -e "s:\$(kde_htmldir):\$(kde_htmldir)/:g" ${KDE_S}/docs/howto/unicode/Makefile.*

	kde_src_compile

	local MAKE_PO MAKE_DOC TMP
	local _S="${KDE_S}"
	if [ -d "${WORKDIR}/${LANGS_PKG}" ]; then
		KDE_S="${WORKDIR}/${LANGS_PKG}"
		cd "${KDE_S}"

		# Adapted from kde.eclass
		if [[ -z ${LINGUAS} ]]; then
			elog "You can add some of the translations of the interface and"
			elog "documentation by setting the \${LINGUAS} variable to the"
			elog "languages you want installed."
			elog
			elog "Enabling English interface and documentation only."
		else
			if [[ -n ${LANGS} ]]; then
				MAKE_PO=$(echo $(echo "${LINGUAS} ${LANGS}" | tr ' ' '\n' | sort | uniq -d))
				TMP=$(echo $(echo "${MAKE_PO/pt_BR/pt_br}" | sort | uniq))
				TMP=$(echo $(echo "${TMP/uk/ua}" | sort | uniq))
				TMP+=" "
				MAKE_PO=${TMP// /.po }

				elog "Enabling translations for: ${MAKE_PO}"
				sed -i -e "s:^POFILES =.*:POFILES = ${MAKE_PO}:" "${KDE_S}/po/Makefile.am" \
					|| die "sed for locale failed"
				rm -f "${KDE_S}/configure"
			fi

			TMP=""

			if [[ -n ${LANGS_DOC} ]]; then
				MAKE_DOC=$(echo $(echo "${LINGUAS} ${LANGS_DOC}" | tr ' ' '\n' | sort | uniq -d))
				TMP=$(echo $(echo "${MAKE_DOC/pt_BR/pt-br}" | sort | uniq))
				TMP=$(echo $(echo "${TMP/uk/ua}" | sort | uniq))
				MAKE_DOC=${TMP}

				elog "Enabling documentation for: ${MAKE_DOC}"
				sed -i -e "s:^SUBDIRS =.*:SUBDIRS = ${MAKE_DOC}:" \
					"${KDE_S}/docs/Makefile.am" || die "sed for locale failed"

				# Those paths are missing a slash.
				for X in ${MAKE_DOC}; do
					[[ -f ${KDE_S}/docs/${X}/handbook/unicode/Makefile.am ]] && \
						sed -i -e "s:\$(kde_htmldir):\$(kde_htmldir)/:g" \
							${KDE_S}/docs/${X}/handbook/unicode/Makefile.am || die "sed for handbook failed"
					[[ -f ${KDE_S}/docs/${X}/handbook/unicode/Makefile.am ]] && \
						sed -i -e "s:\$(kde_htmldir):\$(kde_htmldir)/:g" \
							${KDE_S}/docs/${X}/howto/unicode/Makefile.am || die "sed for howto failed"
				done

				rm -f "${KDE_S}/configure"
			fi
		fi

		kde_src_compile
	fi
	KDE_S="${_S}"
}

src_install() {
	kde_src_install

	local _S="${KDE_S}"
	if [ -d "${WORKDIR}/${LANGS_PKG}" ]; then
		KDE_S="${WORKDIR}/${LANGS_PKG}"
		cd "${KDE_S}"

		kde_src_install
	fi
	KDE_S="${_S}"
}
