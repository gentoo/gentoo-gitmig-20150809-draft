# Copyright 1999-2004 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-oss/alsa-oss-0.9.4.ebuild,v 1.4 2004/03/19 07:56:03 mr_bones_ Exp $

DESCRIPTION="Advanced Linux Sound Architecture OSS compatibility layer."
HOMEPAGE="http://www.alsa-project.org/"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=media-libs/alsa-lib-0.9.4"

SLOT="0"
KEYWORDS="~x86 -sparc ~ppc"

SRC_URI="ftp://ftp.alsa-project.org/pub/oss-lib/${P}.tar.bz2"
S=${WORKDIR}/${P}

src_compile() {
	econf || die "./configure failed"
	emake || die "Parallel Make Failed"
}

src_install() {
	einstall || die
	dodoc COPYING
}
