# Copyright 1999-2003 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/alsa-oss/alsa-oss-1.0.0_rc1.ebuild,v 1.2 2003/12/26 17:14:52 weeve Exp $

DESCRIPTION="Advanced Linux Sound Architecture OSS compatibility layer."
HOMEPAGE="http://www.alsa-project.org/"
LICENSE="GPL-2"

DEPEND="virtual/glibc
	>=media-libs/alsa-lib-1.0.0_rc1"

SLOT="0"
KEYWORDS="~x86 -sparc ~ppc ~amd64"

MY_P=${P/_rc/rc}
#SRC_URI="mirror://alsaproject/oss-lib/${P}.tar.bz2"
SRC_URI="ftp://ftp.alsa-project.org/pub/oss-lib/${MY_P}.tar.bz2"
#RESTRICT="nomirror"
S=${WORKDIR}/${MY_P}

src_compile() {
	econf || die "./configure failed"
	emake || die "Parallel Make Failed"
}

src_install() {
	einstall || die
	dodoc COPYING
}
