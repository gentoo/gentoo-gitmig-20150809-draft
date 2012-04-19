# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-dicts/myspell-es/myspell-es-20120418.ebuild,v 1.1 2012/04/19 07:35:01 scarabeus Exp $

MYSPELL_SPELLING_DICTIONARIES=(
"es,AR,es_AR,Spanish (Argentina),es_AR.zip"
"es,BZ,es_HN,Spanish (Belize),es_HN.zip"
"es,BO,es_BO,Spanish (Bolivia),es_BO.zip"
"es,CL,es_CL,Spanish (Chile),es_CL.zip"
"es,CO,es_CO,Spanish (Colombia),es_CO.zip"
"es,CR,es_CR,Spanish (Costa Rica),es_CR.zip"
"es,CU,es_CU,Spanish (Cuba),es_CU.zip"
"es,DO,es_DO,Spanish (Dominican Republic),es_DO.zip"
"es,EC,es_EC,Spanish (Ecuador),es_EC.zip"
"es,SV,es_SV,Spanish (El Salvador),es_SV.zip"
"es,GT,es_GT,Spanish (Guatemala),es_GT.zip"
"es,HN,es_HN,Spanish (Honduras),es_HN.zip"
"es,MX,es_MX,Spanish (Mexico),es_MX.zip"
"es,NI,es_NI,Spanish (Nicaragua),es_NI.zip"
"es,PA,es_PA,Spanish (Panama),es_PA.zip"
"es,PY,es_PY,Spanish (Paraguay),es_PY.zip"
"es,PE,es_PE,Spanish (Peru),es_PE.zip"
"es,PR,es_PR,Spanish (Puerto Rico),es_PR.zip"
"es,ES,es_ES,Spanish (Spain),es_ES.zip"
"es,UY,es_UY,Spanish (Uruguay),es_UY.zip"
"es,VE,es_VE,Spanish (Venezuela),es_VE.zip"
)

MYSPELL_HYPHENATION_DICTIONARIES=(
"es,AR,hyph_es_ANY,Spanish (Argentina),hyph_es_ANY.zip"
"es,BZ,hyph_es_ANY,Spanish (Belize),hyph_es_ANY.zip"
"es,BO,hyph_es_ANY,Spanish (Bolivia),hyph_es_ANY.zip"
"es,CL,hyph_es_ANY,Spanish (Chile),hyph_es_ANY.zip"
"es,CO,hyph_es_ANY,Spanish (Colombia),hyph_es_ANY.zip"
"es,CR,hyph_es_ANY,Spanish (Costa Rica),hyph_es_ANY.zip"
"es,CU,hyph_es_ANY,Spanish (Cuba),hyph_es_ANY.zip"
"es,DO,hyph_es_ANY,Spanish (Dominican Republic),hyph_es_ANY.zip"
"es,EC,hyph_es_ANY,Spanish (Ecuador),hyph_es_ANY.zip"
"es,SV,hyph_es_ANY,Spanish (El Salvador),hyph_es_ANY.zip"
"es,GT,hyph_es_ANY,Spanish (Guatemala),hyph_es_ANY.zip"
"es,HN,hyph_es_ANY,Spanish (Honduras),hyph_es_ANY.zip"
"es,MX,hyph_es_ANY,Spanish (Mexico),hyph_es_ANY.zip"
"es,NI,hyph_es_ANY,Spanish (Nicaragua),hyph_es_ANY.zip"
"es,PA,hyph_es_ANY,Spanish (Panama),hyph_es_ANY.zip"
"es,PY,hyph_es_ANY,Spanish (Paraguay),hyph_es_ANY.zip"
"es,PE,hyph_es_ANY,Spanish (Peru),hyph_es_ANY.zip"
"es,PR,hyph_es_ANY,Spanish (Puerto Rico),hyph_es_ANY.zip"
"es,ES,hyph_es_ANY,Spanish (Spain),hyph_es_ANY.zip"
"es,UY,hyph_es_ANY,Spanish (Uruguay),hyph_es_ANY.zip"
"es,VE,hyph_es_ANY,Spanish (Venezuela),hyph_es_ANY.zip"
)

MYSPELL_THESAURUS_DICTIONARIES=(
"es,AR,th_es_ES_v2,Spanish (Argentina),th_es_ES_v2.zip"
"es,BZ,th_es_ES_v2,Spanish (Belize),th_es_ES_v2.zip"
"es,BO,th_es_ES_v2,Spanish (Bolivia),th_es_ES_v2.zip"
"es,CL,th_es_ES_v2,Spanish (Chile),th_es_ES_v2.zip"
"es,CO,th_es_ES_v2,Spanish (Colombia),th_es_ES_v2.zip"
"es,CR,th_es_ES_v2,Spanish (Costa Rica),th_es_ES_v2.zip"
"es,CU,th_es_ES_v2,Spanish (Cuba),th_es_ES_v2.zip"
"es,DO,th_es_ES_v2,Spanish (Dominican Republic),th_es_ES_v2.zip"
"es,EC,th_es_ES_v2,Spanish (Ecuador),th_es_ES_v2.zip"
"es,SV,th_es_ES_v2,Spanish (El Salvador),th_es_ES_v2.zip"
"es,GT,th_es_ES_v2,Spanish (Guatemala),th_es_ES_v2.zip"
"es,HN,th_es_ES_v2,Spanish (Honduras),th_es_ES_v2.zip"
"es,MX,th_es_ES_v2,Spanish (Mexico),th_es_ES_v2.zip"
"es,NI,th_es_ES_v2,Spanish (Nicaragua),th_es_ES_v2.zip"
"es,PA,th_es_ES_v2,Spanish (Panama),th_es_ES_v2.zip"
"es,PY,th_es_ES_v2,Spanish (Paraguay),th_es_ES_v2.zip"
"es,PE,th_es_ES_v2,Spanish (Peru),th_es_ES_v2.zip"
"es,PR,th_es_ES_v2,Spanish (Puerto Rico),th_es_ES_v2.zip"
"es,ES,th_es_ES_v2,Spanish (Spain),th_es_ES_v2.zip"
"es,UY,th_es_ES_v2,Spanish (Uruguay),th_es_ES_v2.zip"
"es,VE,th_es_ES_v2,Spanish (Venezuela),th_es_ES_v2.zip"
)

set_fields() {
	local old_IFS
	old_IFS="${IFS}"
	IFS=$2
	fields=($1)
	IFS="${old_IFS}"
}

get_uri() {
	local files fields newfile filestem srcfile dict uris
	files=()
	uris=""
	for dict in \
			"${MYSPELL_SPELLING_DICTIONARIES[@]}" \
			"${MYSPELL_HYPHENATION_DICTIONARIES[@]}" \
			"${MYSPELL_THESAURUS_DICTIONARIES[@]}"; do
		set_fields "${dict}" ","
		newfile=${fields[4]// }
		for file in "${files[@]}"; do
			[[ ${file} == ${newfile} ]] && continue 2
		done
		filestem=${newfile/.zip}
		files=("${files[@]}" "${newfile}")
		srcfile="myspell-${filestem}-${PV}.zip"
		uris+=" http://ravengentoo.perso.sfr.fr/gentoo/app-dicts/${PN}/${PV}/${srcfile}"
	done
	echo "${uris}"
}

SRC_URI=$(get_uri)

inherit myspell

DESCRIPTION="Spanish dictionaries for myspell/hunspell"
LICENSE="GPL-3 LGPL-3 MPL-1.1"
HOMEPAGE="http://rla-es.forja.rediris.es/"
IUSE=""

KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd"
