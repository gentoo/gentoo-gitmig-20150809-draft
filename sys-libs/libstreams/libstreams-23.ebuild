# Copyright 1999-2004 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/libstreams/libstreams-23.ebuild,v 1.2 2004/11/07 21:03:59 kito Exp $

DESCRIPTION="NeXT/Darwin Streams routines."
HOMEPAGE="http://darwinsource.opendarwin.org/10.3.6/"
SRC_URI="http://darwinsource.opendarwin.org/tarballs/apsl/Libstreams-${PV}.tar.gz"

LICENSE="APSL-2"

SLOT="0"
KEYWORDS="~ppc-macos"
IUSE="debug"

DEPEND="virtual/libc"

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}/Libstreams-${PV}
	sed -i -e 's:^NEXTSTEP_INSTALL_DIR = .*:NEXTSTEP_INSTALL_DIR = ${D}/usr/lib/system:' Makefile\
	|| die "sed failed"
	sed -i -e 's:^PRIVATE_HDR_INSTALLDIR = .*:PRIVATE_HDR_INSTALLDIR = ${D}/usr/include:' Makefile.preamble\
	|| die "sed failed"
}

src_compile() {
	emake RC_OS=macos || die "make failed"
	emake profile || die "make profile failed"
	if use debug; then
		emake debug || die "make debug failed"
	fi
}

src_install() {
	insinto /usr/lib/system
	doins *.a

	insinto /usr/include/streams
	doins *.h
}