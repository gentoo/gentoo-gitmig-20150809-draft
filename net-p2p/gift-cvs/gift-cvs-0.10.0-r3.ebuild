# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift-cvs/gift-cvs-0.10.0-r3.ebuild,v 1.2 2003/07/03 23:54:57 lostlogic Exp $

DESCRIPTION="A OpenFT, Gnutella and FastTrack p2p network client"
HOMEPAGE="http://gift.sourceforge.net"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~x86 ~sparc ~ppc"

DEPENDS="virtual/glibc
	>=sys-apps/sed-4
	>=sys-libs/zlib-1.1.4"

inherit cvs debug flag-o-matic

strip-flags

# CVS settings for giFT
ECVS_SERVER="cvs.sourceforge.net:/cvsroot/gift"
ECVS_MODULE="giFT"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S=${WORKDIR}/${ECVS_MODULE}

src_compile() {

	# Compile giFT. Gnutella support is enabled by default (can be switched off).
	cd ${S}
	./autogen.sh --prefix=/usr --enable-gnutella --host=${CHOST} || die "Bootstrap configure failed"
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "Make failed"

}

src_install() {

	# Install giFT.
	cd ${S}
	einstall giftconfdir=${D}/etc/giFT \
		 plugindir=${D}/usr/lib/giFT \
		 giftdatadir=${D}/usr/share/giFT \
		 giftperldir=${D}/usr/bin \
		 libgiftincdir=${D}/usr/include/libgift || die "Install failed"

	# Fix the giFT-setup executable.
	cd ${D}/usr/bin
	sed -i -e 's:$prefix/etc/giFT/:/etc/giFT/:' giFT-setup

}

pkg_postinst() {
	einfo "First of all you need to run giFT-setup with your normal"
	einfo "user account to create the giFT configuration files."
	echo
	einfo "FastTrack support is no longer in this build, please"
	einfo "emerge net-p2p/gift-fasttrack-cvs for FastTrack support"
}

