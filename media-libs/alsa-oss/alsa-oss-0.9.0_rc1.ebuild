# Copyright 1999-2000 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-oss/alsa-oss-0.9.0_rc1.ebuild,v 1.5 2002/07/11 06:30:38 drobbins Exp $

DESCRIPTION="Advanced Linux Sound Architecture OSS compatibility layer"
HOMEPAGE="http://www.alsa-project.org/"

DEPEND="virtual/glibc 
	>=media-libs/alsa-lib-0.9.0_rc1"

SRC_URI="ftp://ftp.alsa-project.org/pub/oss-lib/${P/_rc/rc}.tar.bz2"
S="${WORKDIR}/${P/_rc/rc}"

src_compile() {				  
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--mandir=/usr/share/man \
		|| die "./configure failed"
	emake || die "Parallel Make Failed"
}

src_install() {
	make DESTDIR="${D}" install || die
	dodoc COPYING
}
