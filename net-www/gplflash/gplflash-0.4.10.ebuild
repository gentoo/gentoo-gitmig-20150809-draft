# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Id: gplflash-0.4.10.ebuild,v 1.10 2003/02/13 15:34:08 vapier Exp $

S=${WORKDIR}/flash-0.4.10
DESCRIPTION="GPL Shockwave Flash Player/Plugin"
SRC_URI="http://www.swift-tools.com/Flash/flash-0.4.10.tgz"
HOMEPAGE="http://www.swift-tools.com/Flash"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="media-libs/libflash"

PATCH=${FILESDIR}/gentoo.diff

src_unpack() {
	cd ${WORKDIR}
	unpack flash-0.4.10.tgz
	cd ${S}
	cat ${PATCH} | patch -p0 || die
}

src_compile() {
	emake || die
}

src_install() {															 
	cd ${S}/Plugin
	insinto /opt/netscape/plugins
	doins npflash.so
	cd ${S}
	dodoc README ReadMe.htm
	
	if [ "`use mozilla`" ] ; then
		dodir /usr/lib/mozilla/plugins
		dosym /opt/netscape/plugins/npflash.so \
			/usr/lib/mozilla/plugins/npflash.so 
	fi
}
