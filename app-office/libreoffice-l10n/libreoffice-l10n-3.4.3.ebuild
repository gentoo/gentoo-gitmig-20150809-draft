# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-office/libreoffice-l10n/libreoffice-l10n-3.4.3.ebuild,v 1.3 2011/09/03 21:04:35 scarabeus Exp $

EAPI=4

RC_VERSION="rc2" # CHECK ME WITH EVERY BUMP!
BASE_SRC_URI="http://download.documentfoundation.org/${PN/-l10n/}/stable/${PV}/rpm/"
inherit rpm eutils versionator

DESCRIPTION="Translations for the Libreoffice suite."
HOMEPAGE="http://www.libreoffice.org"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux ~x86-linux"
IUSE="offlinehelp"

LANGUAGES="af ar as ast be bg bn bo br brx bs ca ca_XV cs cy da de dgo dz el
en en_GB en_ZA eo es et eu fa fi fr ga gl gu he hi hr hu id is it ja ka kk km
kn kok ko ks ku lo lt lv mai mk ml mn mni mr my nb ne nl nn nr nso oc or
pa_IN pl pt pt_BR ro ru rw sat sd sh sk sl sq sr ss st sv sw_TZ ta te tg
th tn tr ts ug uk uz ve vi xh zh_CN zh_TW zu"
# Only some languages have the translations availible.
# This is always subset of the above, so no need to add it again to IUSE.
LANGUAGES_HELP="bg bn bo bs ca ca_XV cs da de dz el en en_GB en_ZA eo es et eu
fi fr gl gu he hi hr hu id is it ja ka km ko mk nb ne nl nn om pl pt pt_BR ru si
sk sl sq sv tg tr ug uk vi zh_CN zh_TW"
for lang in ${LANGUAGES}; do
	helppack=""
	langpack=""
	if [[ "${LANGUAGES_HELP}" =~ "${lang}" ]]; then
		[[ ${lang} == en ]] && lang2=${lang/en/en_US} || lang2=${lang}
		helppack=" offlinehelp? ( ${BASE_SRC_URI}/x86/LibO_${PV}_Linux_x86_helppack-rpm_${lang2/_/-}.tar.gz ) "
	fi
	[[ ${lang} == en ]] \
		|| langpack=" ${BASE_SRC_URI}/x86/LibO_${PV}_Linux_x86_langpack-rpm_${lang/_/-}.tar.gz "
	SRC_URI+=" linguas_${lang}? (
		${langpack}
		${helppack}
	)"
	IUSE+=" linguas_${lang}"
done
unset lang helppack langpack lang2

# dictionaries
SPELL_DICTS="af bg ca cs cy da de el en eo es et fr ga gl he hr hu it ku lt mk
nb nl nn pl pt ru sk sl sv tn zu"
for X in ${SPELL_DICTS} ; do
	SPELL_DICTS_DEPEND+=" linguas_${X}? ( app-dicts/myspell-${X} )"
done
unset X
RDEPEND="${SPELL_DICTS_DEPEND}"
unset X SPELL_DICTS SPELL_DICTS_DEPEND

# blockers for old libreoffice with linguas bundled
RDEPEND+="
	!<=app-office/libreoffice-3.4.3.2
	!=app-office/libreoffice-3.4.9999
	!=app-office/libreoffice-9999
	!<=app-office/libreoffice-bin-3.4.3-r1
"

RESTRICT="strip"

S="${WORKDIR}"

src_unpack() {
	default

	local lang dir rpmdir

	for lang in ${LINGUAS}; do
		dir=${lang/_/-}

		# for english we provide just helppack, as translation is always there
		if [[ ${lang} != en ]]; then
			rpmdir="LibO_${PV}${RC_VERSION}_Linux_x86_langpack-rpm_${dir}/RPMS/"
			rpm_unpack "./${rpmdir}/"*.rpm
		fi

		if use offlinehelp; then
			[[ ${lang} == en ]] && dir="en-US"
			rpmdir="LibO_${PV}${RC_VERSION}_Linux_x86_helppack-rpm_${dir}/RPMS/"
			rpm_unpack ./"${rpmdir}/"*.rpm
		fi
	done
}

src_prepare() { :; }
src_configure() { :; }
src_compile() { :; }

src_install() {
	# Condition required for people that do not install anything eg no linguas
	# or just english with no offlinehelp.
	if [[ -d "${S}"/opt/${PN/-l10n/}$(get_version_component_range 1-2)/ ]] ; then
		insinto /usr/$(get_libdir)/${PN/-l10n/}
		doins -r "${S}"/opt/${PN/-l10n/}$(get_version_component_range 1-2)/*
	fi
}
