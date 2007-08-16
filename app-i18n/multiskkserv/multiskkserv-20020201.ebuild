# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/multiskkserv/multiskkserv-20020201.ebuild,v 1.13 2007/08/16 16:12:55 matsuu Exp $

inherit eutils fixheadtails

CDB_PV=0.75
CDB_PN=cdb
CDB_P=${CDB_PN}-${CDB_PV}

DESCRIPTION="SKK server that handles multiple dictionaries"
HOMEPAGE="http://www3.big.or.jp/~sian/linux/products/"
SRC_URI="http://www3.big.or.jp/~sian/linux/products/${P}.tar.bz2
	http://cr.yp.to/cdb/${CDB_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="x86 ppc sparc alpha"
IUSE=""

DEPEND="virtual/libc
	|| (
		>=app-i18n/skk-jisyo-200705
		app-i18n/skk-jisyo-cdb
	)"
PROVIDE="virtual/skkserv"

pkg_setup() {
	if has_version '>=app-i18n/skk-jisyo-200705' && ! built_with_use '>=app-i18n/skk-jisyo-200705' cdb ; then
		eerror "multiskkserv requires skk-jisyo to be built with cdb support. Please add"
		eerror "'cdb' to your USE flags, and re-emerge app-i18n/skk-jisyo."
		die "Missing cdb USE flag."
	fi
}

src_unpack() {
	unpack ${A}

	cd ${WORKDIR}/${CDB_P}
	epatch ${FILESDIR}/${CDB_P}-errno.diff
	ht_fix_all

	cd ${S}
	ht_fix_all

	cd ${S}/src
	epatch ${FILESDIR}/${P}-gcc34.diff
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
	make DESTDIR=${D} install || die

	newconfd ${FILESDIR}/multiskkserv.conf multiskkserv

	newinitd ${FILESDIR}/multiskkserv.initd multiskkserv

	dodoc AUTHORS ChangeLog INSTALL NEWS README*
}

pkg_postinst() {
	elog "By default, multiskkserv will look up only SKK-JISYO.L."
	elog "If you want to use more dictionaries,"
	elog "edit /etc/conf.d/multiskkserv manually."
}
