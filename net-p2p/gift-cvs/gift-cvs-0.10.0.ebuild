# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift-cvs/gift-cvs-0.10.0.ebuild,v 1.8 2003/06/21 20:19:52 lostlogic Exp $

DESCRIPTION="Lets you connect to OpenFT, a decentralised p2p network like FastTrack"
HOMEPAGE="http://gift.sourceforge.net"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86 sparc ~ppc"

DEPENDS="virtual/glibc
        >=sys-libs/zlib-1.1.4"

inherit cvs debug flag-o-matic

strip-flags

ECVS_SERVER="cvs.sourceforge.net:/cvsroot/gift"
ECVS_MODULE="giFT"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S=${WORKDIR}/${ECVS_MODULE}

src_compile() {

        cd ${S}
        ./autogen.sh --prefix=/usr --host=${CHOST} || die
        emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die

}

src_install() {

        einstall giftconfdir=${D}/etc/giFT \
                 plugindir=${D}/usr/lib/giFT \
                 giftdatadir=${D}/usr/share/giFT \
                 giftperldir=${D}/usr/bin \
		 libgiftincdir=${D}/usr/include/libgift || die
        cd ${D}/usr/bin
        mv giFT-setup giFT-setup.orig
        sed 's:$prefix/etc/giFT/:/etc/giFT/:' giFT-setup.orig > giFT-setup
        chmod +x ${D}/usr/bin/giFT-setup

}

