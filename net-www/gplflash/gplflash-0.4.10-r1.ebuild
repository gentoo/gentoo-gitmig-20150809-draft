# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-www/gplflash/gplflash-0.4.10-r1.ebuild,v 1.12 2003/06/12 22:07:00 msterret Exp $

S=${WORKDIR}/flash-0.4.10
DESCRIPTION="GPL Shockwave Flash Player/Plugin"
SRC_URI="http://www.swift-tools.com/Flash/flash-0.4.10.tgz"
HOMEPAGE="http://www.swift-tools.com/Flash"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 ppc sparc "

DEPEND="media-libs/libflash"

src_unpack() {
	cd ${WORKDIR}
	unpack flash-0.4.10.tgz
	cd ${S}
	patch -p1 <${FILESDIR}/${P}-gcc3-gentoo.diff || die
}

src_compile() {
	emake || die
}

src_install() {															 
	cd ${S}/Plugin
	insinto /opt/netscape/plugins
	doins npflash.so
	cd ${S}
	dodoc README COPYING
	
	if [ "`use mozilla`" ] ; then
		dodir /usr/lib/mozilla/plugins
		dosym /opt/netscape/plugins/npflash.so \
			/usr/lib/mozilla/plugins/npflash.so 
	fi
}
