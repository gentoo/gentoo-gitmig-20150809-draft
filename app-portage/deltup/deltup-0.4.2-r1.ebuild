# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-portage/deltup/deltup-0.4.2-r1.ebuild,v 1.5 2005/08/13 23:55:01 yoswink Exp $

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Delta-Update - patch system for updating source-archives."
HOMEPAGE="http://deltup.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz
		http://www.bzip.org/1.0.2/bzip2-1.0.2.tar.gz"
SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"
IUSE=""

DEPEND="dev-libs/openssl
	sys-libs/zlib
	>=app-arch/bzip2-1.0.0
	virtual/libc"
RDEPEND="${DEPEND}
	|| ( dev-util/bdelta >=dev-util/xdelta-1.1.3 )
	>=app-arch/bzip2-1.0.3"

src_unpack () {
	unpack ${A}
	cd ${S}
	sed -i -e "s/a .9 version/a 1.0.2 version/g" deltup.cpp
	sed -i -e "s/1.0.0/1.0.3/g" deltup.cpp

	cd ${WORKDIR}/bzip2-1.0.2
	epatch ${FILESDIR}/bzip2-1.0.2-makefile-CFLAGS.patch
}

src_compile () {
	emake || die "emake getdelta failed"

	cd ${WORKDIR}/bzip2-1.0.2
	local makeopts="
		CC=$(tc-getCC)
		AR=$(tc-getAR)
		RANLIB=$(tc-getRANLIB)"
	append-flags -static
	emake ${makeopts} bzip2 || die "emake bzip2 failed"
	mv bzip2 bzip2_old
}

src_install () {
	make DESTDIR=${D} install || die "make install failed"
	dodoc README ChangeLog GENTOO
	doman deltup.1

	dobin ${WORKDIR}/bzip2-1.0.2/bzip2_old
}
