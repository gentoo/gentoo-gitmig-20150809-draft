# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/libnet/libnet-1.0.2a-r3.ebuild,v 1.9 2004/01/17 13:47:41 mr_bones_ Exp $

inherit eutils

S="${WORKDIR}/Libnet-${PV}"
DESCRIPTION="library to provide an API for commonly used low-level network functions (mainly packet injection)"
HOMEPAGE="http://www.packetfactory.net/libnet/"
SRC_URI="http://www.packetfactory.net/libnet/dist/deprecated/${P}.tar.gz"

KEYWORDS="x86 ppc sparc arm alpha amd64"
LICENSE="LGPL-2"
SLOT="1.0"
IUSE=""

src_unpack() {
	unpack ${A}
	epatch ${FILESDIR}/libnet-gcc33-fix
	epatch ${FILESDIR}/${PV}-slot.patch
	cd ${S}
	mv libnet-config.in libnet-${SLOT}-config.in || die "moving libnet-config"
	cd ${S}/include
	ln -s libnet.h libnet-${SLOT}.h
	cd libnet
	for f in *.h ; do
		ln -s ${f} ${f/-/-${SLOT}-} || die "linking ${f}"
	done
	cd ${S}/doc
	ln -s libnet.3 libnet-${SLOT}.3 || die "linking manpage"
	cd ${S}
	autoconf || die
}

src_compile() {
	econf || die
	emake CFLAGS="${CFLAGS}" || die "Failed to compile"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"

	dodoc VERSION doc/{README,TODO*,CHANGELOG*} || die "dodoc failed"
	newdoc README README.1st || die "newdoc failed"
	docinto example ; dodoc example/libnet* || die "dodoc failed (example)"
	docinto Ancillary ; dodoc doc/Ancillary/* || die "dodoc failed (Ancillary)"
}

pkg_postinst(){
	einfo "libnet ${SLOT} is deprecated !"
	einfo "config script: libnet-${SLOT}-config"
	einfo "manpage: libnet-${SLOT}"
	einfo "library: libnet-${SLOT}.a"
	einfo "include: libnet-${SLOT}.h"
}
