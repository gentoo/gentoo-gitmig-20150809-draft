# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/libdvb/libdvb-0.5.0.ebuild,v 1.3 2003/10/06 07:00:31 mr_bones_ Exp $

IUSE=""

S=${WORKDIR}/${P}
DESCRIPTION="libdvb package with added CAM library and libdvbmpegtools as well as dvb-mpegtools"
HOMEPAGE="http://www.metzlerbros.org/dvb/"
SRC_URI="http://www.metzlerbros.org/dvb/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="x86"

DEPEND=">=sys-apps/sed-4
	>=media-tv/linuxtv-dvb-1.0.1"

src_compile() {
	# applying a patch to DVB.cc (compile error)
	patch -p0 ${S}/libdvb/DVB.cc < ${FILESDIR}/DVB.cc-0.5.0.patch
	# patch to Makefile 
	#(disable compilation of sample programs because of a compile error)
	patch -p0 ${S}/Makefile < ${FILESDIR}/Makefile-0.5.0.patch
	# patch to dvb-mpegtools Makefile to make correct links
	patch -p0 ${S}/dvb-mpegtools/Makefile < ${FILESDIR}/dvb-mpegtools-Makefile-0.5.0.patch
	emake || die
}

src_install() {
	make DESTDIR=${D} PREFIX=/usr install || die
	dodoc README
	insinto /usr/doc/${P}/sample_progs
	doins sample_progs/*
	insinto /usr/doc/${P}/samplerc
	doins samplerc/*
}
