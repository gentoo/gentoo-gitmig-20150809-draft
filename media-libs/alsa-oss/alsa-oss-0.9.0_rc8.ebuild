# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-oss/alsa-oss-0.9.0_rc8.ebuild,v 1.3 2003/12/26 17:14:52 weeve Exp $

DESCRIPTION="Advanced Linux Sound Architecture OSS compatibility layer."
HOMEPAGE="http://www.alsa-project.org/"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=media-libs/alsa-lib-0.9.0_rc7"

SLOT="0"
KEYWORDS="~x86 -sparc ~ppc"

SRC_URI="ftp://ftp.alsa-project.org/pub/oss-lib/${P/_/}.tar.bz2"
S=${WORKDIR}/${P/_/}

src_compile() {
	econf || die "./configure failed"
	emake || die "Parallel Make Failed"
}

src_install() {
	einstall || die
	dodoc COPYING
}
