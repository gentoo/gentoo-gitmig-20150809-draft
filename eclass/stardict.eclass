# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/eclass/stardict.eclass,v 1.6 2004/07/30 21:31:52 arj Exp $

# Author : Alastair Tse <liquidx@gentoo.org>
#
# Convienence class to do stardict dictionary installations.
# 
# Usage:
#   - Variables to set :
#      * FROM_LANG     -  From this language
#      * TO_LANG       -  To this language
#      * DICT_PREFIX   -  SRC_URI prefix, like "dictd_www.mova.org_"
#	   * DICT_SUFFIX   -  SRC_URI after the prefix.

ECLASS="stardict"
INHERITED="$INHERITED $ECLASS"

RESTRICT="nostrip"

[ -z "${DICT_SUFFIX}" ] && DICT_SUFFIX=${PN#stardict-[a-z]*-}
[ -z "${DICT_P}" ] && DICT_P=stardict-${DICT_PREFIX}${DICT_SUFFIX}-${PV}

if [ -n "${FROM_LANG}" -a -n "${TO_LANG}" ]; then
	DESCRIPTION="Stardict Dictionary ${FROM_LANG} to ${TO_LANG}"
elif [ -z "${DESCRIPTION}" ]; then
	DESCRIPTION="Another Stardict Dictionary"
fi	
	
HOMEPAGE="http://stardict.sourceforge.net/"
SRC_URI="mirror://sourceforge/stardict/${DICT_P}.tar.bz2"

IUSE=""
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86"

DEPEND=">=app-dicts/stardict-2.1"

S=${WORKDIR}/${DICT_P}

stardict_src_compile() {
	return
}

stardict_src_install() {
	insinto /usr/share/stardict/dic
	echo `pwd`
	doins *.dict.dz
	doins *.idx*
	doins *.ifo
}

EXPORT_FUNCTIONS src_compile src_install
