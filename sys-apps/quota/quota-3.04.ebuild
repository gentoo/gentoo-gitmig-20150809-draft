# Copyright 1999-2002 Gentoo Technologies, Inc.
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: /var/cvsroot/gentoo-x86/sys-apps/quota/quota-3.04.ebuild,v 1.8 2002/08/14 04:40:34 murphy Exp $

S=${WORKDIR}/quota-tools
DESCRIPTION="Linux quota tools"
SRC_URI="mirror://sourceforge/linuxquota/${P}.tar.gz"
HOMEPAGE="http://sourceforge.net/projects/linuxquota/"
KEYWORDS="x86 ppc sparc sparc64"
SLOT="0"
LICENSE="GPL-2"

DEPEND="virtual/glibc"

src_compile() {
	./configure \
		--host=${CHOST} \
		--prefix=/usr \
		--infodir=/usr/share/info \
		--mandir=/usr/share/man || die "./configure failed"
	emake || die
}

src_install () {
	mkdir -p ${D}/{sbin,etc,usr/sbin,usr/bin,usr/share/man/man{1,2,3,8}}
	make ROOTDIR=${D} install || die
	install -m 644 warnquota.conf ${D}/etc
	dodoc doc/*
}
