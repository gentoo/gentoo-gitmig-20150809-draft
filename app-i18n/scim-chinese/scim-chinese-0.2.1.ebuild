# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-i18n/scim-chinese/scim-chinese-0.2.1.ebuild,v 1.1 2003/05/25 15:10:52 liquidx Exp $

DESCRIPTION="Smart Common Input Method (SCIM) Closed Source Pinyin Input Method"
HOMEPAGE="http://www.gnuchina.org/~suzhe/scim/"
SRC_URI="http://www.gnuchina.org/~suzhe/scim/scim-chinese/${P}-1.i586.rpm"

LICENSE="scim-chinese"
SLOT="0"
KEYWORDS="~x86 -*"
IUSE=""

RDEPEND="virtual/x11
	>=app-i18n/scim-0.4.1"
	
DEPEND="${RDEPEND}
	app-arch/rpm"

S=${WORKDIR}

src_unpack() {
	cd ${S}
	rpm2cpio ${DISTDIR}/${A} | cpio -i --make-directories
}

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
	# get installed scim version
	SCIM_VER=$(scim -h | grep "Smart Common Input Method" | awk '{print $5}')
	
	# install into /opt because this is binary-only
	PREFIX=/opt/scim-chinese
	
	cd ${S}
	insinto ${PREFIX}/lib/scim-1.0/Server
	doins usr/lib/scim-1.0/Server/*
	dosym_r ${PREFIX}/lib/scim-1.0/Server /usr/lib/scim-1.0/${SCIM_VER}/Server

	insinto ${PREFIX}/share/scim/chinese
	doins usr/share/scim/chinese/*
	dosym_r ${PREFIX}/share/scim/chinese /usr/share/scim/chinese
	
	insinto /etc/gconf/schemas
	doins etc/gconf/schemas/*
	dodoc usr/share/doc/packages/scim-chinese-0.2.1/{AUTHORS,COPYING,README}
}
