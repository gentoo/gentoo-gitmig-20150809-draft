# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/multiskkserv/multiskkserv-20020201.ebuild,v 1.5 2003/12/27 05:10:55 nakano Exp $

inherit eutils

CDB_PV=0.75
CDB_PN=cdb
CDB_P=${CDB_PN}-${CDB_PV}

DESCRIPTION="SKK server that handles multiple dictionaries"
HOMEPAGE="http://www3.big.or.jp/~sian/linux/products/"
SRC_URI="http://www3.big.or.jp/~sian/linux/products/${P}.tar.bz2
	http://cr.yp.to/cdb/${CDB_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 alpha sparc ppc"

DEPEND="virtual/glibc
	app-i18n/skk-jisyo-cdb"
PROVIDE="virtual/skkserv"

pkg_setup() {
	einfo "If you want to add some extra SKK dictionaries,"
	einfo "please emerge app-i18n/skk-jisyo-extra first."
}

src_unpack() {
	unpack ${A}

	cd ${WORKDIR}/${CDB_P}
	epatch ${FILESDIR}/${CDB_P}-errno.diff

	cp ${FILESDIR}/multiskkserv.conf ${S}

	cd ${WORKDIR}
	epatch ${FILESDIR}/${P}-gentoo.diff
}

src_compile() {
	cd ${WORKDIR}/${CDB_P}
	make || die
	cd -

	cd /usr/share/skk
	echo "# Available SKK-JISYO files are:" >> ${S}/multiskkserv.conf
	for i in *.cdb ; do
		echo "#   ${i}" >> ${S}/multiskkserv.conf
	done
	cd -

	econf --with-cdb=${WORKDIR}/${CDB_P} || die
	emake || die
}

src_install() {
	einstall || die

	insinto /etc/conf.d
	newins multiskkserv.conf multiskkserv

	exeinto /etc/init.d
	newexe ${FILESDIR}/multiskkserv.initd multiskkserv

	dodoc AUTHORS ChangeLog INSTALL NEWS README*
}

pkg_postinst() {
	einfo "By default, multiskkserv will look up only SKK-JISYO.L."
	einfo "If you want to use more dictionaries,"
	einfo "edit /etc/conf.d/multiskkserv manually."
}
