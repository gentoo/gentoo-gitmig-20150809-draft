# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-chinese/scim-chinese-0.2.7.ebuild,v 1.1 2004/02/07 07:20:18 liquidx Exp $

inherit rpm

DESCRIPTION="Smart Common Input Method (SCIM) Closed Source Pinyin Input Method"
HOMEPAGE="http://www.turbolinux.com.cn/~suzhe/scim/"
SRC_URI="http://www.turbolinux.com.cn/~suzhe/scim/scim-chinese/${P}-1.i586.rpm"

LICENSE="scim-chinese"
SLOT="0"
KEYWORDS="~x86 -*"
IUSE=""

DEPEND="virtual/x11
	>=app-i18n/scim-0.9.0"

S=${WORKDIR}

src_compile() {
	return
}

dosym_r() {
	srcdir=$1
	dstdir=$2

	for x in `find ${D}${srcdir}`; do
		dst=${dstdir}${x#$D$srcdir}
		src=${x#$D}
		einfo "Linking $src to $dst"
		if [ ! -d "`dirname $D$dst`" ]; then
			dodir ${dst}
		fi
		dosym $src $dst
	done

}

src_install() {
	# install into /opt because this is binary-only
	PREFIX=/opt/scim-chinese

	cd ${S}
	insinto ${PREFIX}/lib/scim-1.0/Server
	doins usr/lib/scim-1.0/Server/*
	dodir /usr/lib/scim-1.0
	dosym ${PREFIX}/lib/scim-1.0/Server /usr/lib/scim-1.0/Server

	insinto ${PREFIX}/share/scim/chinese
	doins usr/share/scim/chinese/*
	dosym_r ${PREFIX}/share/scim/chinese /usr/share/scim/chinese

	insinto /etc/gconf/schemas
	doins etc/gconf/schemas/*
	dodoc usr/share/doc/packages/${PN}/{AUTHORS,COPYING,README}
}
