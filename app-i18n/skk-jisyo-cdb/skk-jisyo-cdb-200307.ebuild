# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/skk-jisyo-cdb/skk-jisyo-cdb-200307.ebuild,v 1.2 2003/08/01 20:28:55 usata Exp $

IUSE=""

DESCRIPTION="Dictionary files for the SKK Japanese-input software in CDB format"
HOMEPAGE="http://openlab.ring.gr.jp/skk/dic.html"
SRC_PATH="http://www.tkd.ne.jp/~toru/skk/"
SRC_URI="${SRC_PATH}/SKK-JISYO.L.unannotated.${PV}.cdb.gz
	${SRC_PATH}/SKK-JISYO.M.${PV}.cdb.gz
	${SRC_PATH}/SKK-JISYO.S.${PV}.cdb.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"

DEPEND="sys-apps/gzip"
RDEPEND=""

S=${WORKDIR}

src_compile () {

	echo "${PN} doesn't need to be compiled! ;)"
}

src_install () {

	# install dictionaries
	insinto /usr/share/skk
	newins SKK-JISYO.L.unannotated.${PV}.cdb SKK-JISYO.L.cdb || die
	newins SKK-JISYO.M.${PV}.cdb SKK-JISYO.M.cdb || die
	newins SKK-JISYO.S.${PV}.cdb SKK-JISYO.S.cdb || die
}
