# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skk-jisyo/skk-jisyo-200303.ebuild,v 1.2 2003/06/29 22:12:04 aliz Exp $

DESCRIPTION="Jisyo (dictionary) files for the SKK Japanese-input software"
HOMEPAGE="http://openlab.ring.gr.jp/skk/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ~ppc ~sparc ~alpha"

MY_PN="`echo ${PN} | gawk '{ print toupper($1) }'`"
SRC_PATH="http://gentoojp.sourceforge.jp/distfiles/${PN}"
SRC_URI="${SRC_PATH}/${MY_PN}.L.unannotated.${PV}.gz
	${SRC_PATH}/${MY_PN}.M.${PV}.gz
	${SRC_PATH}/${MY_PN}.S.${PV}.gz"

DEPEND="sys-apps/bzip2
	sys-apps/gawk"

RDEPEND=""

S=${WORKDIR}

src_unpack() {
	unpack ${A}
}

src_compile () {
	echo "${MY_PN} don't need to be compiled! ;)"
}

src_install () {
	# install dictionaries
	insinto /usr/share/skk
	newins ${MY_PN}.L.unannotated.${PV} ${MY_PN}.L || die
	newins ${MY_PN}.M.${PV} ${MY_PN}.M || die
	newins ${MY_PN}.S.${PV} ${MY_PN}.S || die
}

