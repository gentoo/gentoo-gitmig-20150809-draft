# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/gift-cvs/gift-cvs-0.12.0.ebuild,v 1.3 2003/06/10 02:24:28 lostlogic Exp $

DESCRIPTION="A OpenFT, Gnutella and FastTrack p2p network client"
HOMEPAGE="http://gift.sourceforge.net"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="-x86 -sparc -ppc"

DEPENDS="virtual/glibc
		>=sys-apps/sed-4
		>=sys-libs/zlib-1.1.4"

inherit cvs debug flag-o-matic

strip-flags

# CVS settings for giFT
ECVS_SERVER="cvs.gift.sourceforge.net:/cvsroot/gift"
ECVS_MODULE="giFT"
ECVS_TOP_DIR="${DISTDIR}/cvs-src/${PN}"
S=${WORKDIR}/${ECVS_MODULE}


src_unpack() {

	local ECVS_MODULE_GIFT
	local ECVS_MODULE_FTPLUGIN

	# Fetch and unpack the giFT cvs sources
	ECVS_MODULE_GIFT=${ECVS_MODULE}
	cvs_src_unpack

	# CVS settings for the FastTrack plugin
	ECVS_SERVER="cvs.gift-fasttrack.berlios.de:/cvsroot/gift-fasttrack"
	ECVS_MODULE="giFT-FastTrack"
	ECVS_TOP_DIR="${DISTDIR}/cvs-src/gift-fasttrack-cvs"

	# Fetch and unpack the cvs sources of the FastTrack plugin
	ECVS_MODULE_FTPLUGIN=${ECVS_MODULE}
	cvs_src_unpack

	# Move the FastTrack plugin to the right position
	mv ${WORKDIR}/${ECVS_MODULE_FTPLUGIN} ${WORKDIR}/${ECVS_MODULE_GIFT}/FastTrack || die

}

src_compile() {

	# Compile giFT. Gnutella support is enabled by default (can be switched off).
	cd ${S}
	./autogen.sh --prefix=/usr --enable-gnutella --host=${CHOST} || die "Bootstrap configure failed"
	emake CFLAGS="${CFLAGS}" CXXFLAGS="${CXXFLAGS}" || die "Make failed"

	# Compile the FastTrack plugin. The developers of this thing sure as hell don't like automated installs.
	cd ${S}/FastTrack
	sed -i -e "s:\$(HOME)/.giFT:${D}/etc/giFT:" \
	       -e "s:/usr/local/lib/giFT:${D}/usr/lib/giFT:" \
	       -e "s:LIBGIFT_CFLAGS =:#LIBGIFT_CFLAGS =:" \
	       -e "s:LIBGIFT_LDFLAGS =:#LIBGIFT_LDFLAGS =:" Makefile
	sed -i -e "s:#include <libgift/proto/:#include <../plugin/:" \
	       -e "s:#include <libgift/:#include <../lib/:" *.c *.h
	emake || die "FastTrack plugin failed to build"

}

src_install() {

	# Install giFT.
	cd ${S}
	einstall giftconfdir=${D}/etc/giFT \
		 plugindir=${D}/usr/lib/giFT \
		 giftdatadir=${D}/usr/share/giFT \
		 giftperldir=${D}/usr/bin \
		 libgiftincdir=${D}/usr/include/libgift || die "Install failed"
	# Install the FastTrack plugin.
	cd ${S}/FastTrack
	einstall || "FastTrack plugin failed to install"

	# Fix the giFT-setup executable.
	cd ${D}/usr/bin
	sed -i -e 's:$prefix/etc/giFT/:/etc/giFT/:' giFT-setup

}

pkg_postinst() {
	einfo "First of all you need to run giFT-setup with your normal"
	einfo "user account to create the giFT configuration files."
	echo
	einfo "To run giFT with FastTrack support, run:"
	einfo "giFT -p /usr/lib/giFT/FastTrack.so"
	echo
	einfo "Alternatively you can add the following line to"
	einfo "your ~/.giFT/gift.conf configuration file:"
	einfo "plugins = OpenFT:/usr/lib/giFT/FastTrack.so"
}

